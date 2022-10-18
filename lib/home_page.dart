import 'package:flutter/material.dart';
import 'package:habbit_tracker/components/habit_tile.dart';
import 'package:habbit_tracker/data/habit_database.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'components/monthly_summary.dart';
import 'components/my_alert_dialog.dart';
import 'components/floating_action_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HabitDatabase db = HabitDatabase();

  final _myBox = Hive.box("Habit_dataBase");

  @override
  void initState() {
    if (_myBox.get("CURRENT_HABIT_LIST") == null) {
      db.createDefaultData();
    } else {
      db.loadData();
    }

    db.updateDatabase();
    super.initState();
  }

  bool habitCompleted = false;

  final _newHabitController = TextEditingController();

  void createNewHabit() {
    showDialog(
        context: context,
        builder: (context) {
          return MyAlertDialog(
              controller: _newHabitController,
              onSave: saveNewHabit,
              onCancel: cancelNewHabit);
        });
    db.updateDatabase();
  }

  void saveNewHabit() {
    setState(() {
      db.todaysHabitList.add([_newHabitController.text, false]);
      db.updateDatabase();
    });

    _newHabitController.clear();
    Navigator.of(context).pop();
  }

  void cancelNewHabit() {
    _newHabitController.clear();
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  void checkBoxTapped(bool? value, int index) {
    setState(() {
      db.todaysHabitList[index][1] = value;
      db.updateDatabase();
    });
  }

  void saveExistingHabit(int index) {
    setState(() {
      db.todaysHabitList[index][0] = _newHabitController.text;
    });
    _newHabitController.clear();
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  void openHabitSettings(int index) {
    showDialog(
        context: context,
        builder: (context) {
          return MyAlertDialog(
              controller: _newHabitController,
              onSave: () => saveExistingHabit(index),
              onCancel: cancelNewHabit);
        });
    db.updateDatabase();
  }

  void deleteHabit(int index) {
    setState(() {
      db.todaysHabitList.removeAt(index);
      db.updateDatabase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: MyFloatingActionButton(
          onPressed: createNewHabit,
        ),
        backgroundColor: Colors.grey[300],
        body: ListView(
          children: [
            MonthlySummary(
                datasets: db.heatMapDataSet,
                startDate: _myBox.get("START_DATE")),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: db.todaysHabitList.length,
                itemBuilder: (context, index) {
                  return HabitTile(
                    habitName: db.todaysHabitList[index][0],
                    isDone: db.todaysHabitList[index][1],
                    onChanged: (value) => checkBoxTapped(value, index),
                    deleteTapped: (context) => deleteHabit(index),
                    settingsTapped: (context) => openHabitSettings(index),
                  );
                })
          ],
        ));
  }
}
