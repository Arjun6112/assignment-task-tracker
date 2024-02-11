import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habbit_tracker/components/habit_tile.dart';
import 'package:habbit_tracker/data/habit_database.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'components/monthly_summary.dart';
import 'components/my_alert_dialog.dart';

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
  Priorities priority = Priorities.Normal;

  final _newTaskController = TextEditingController();
  final _newDescirptionController = TextEditingController();

  void createNewHabit() {
    showDialog(
        context: context,
        builder: (context) {
          return MyAlertDialog(
            onPriorityChange: (value) {
              priority = value;
              setState(() {});
            },
            onSave: saveNewHabit,
            onCancel: cancelNewHabit,
            titleController: _newTaskController,
            descriptionController: _newDescirptionController,
            priority: priority,
          );
        });
    db.updateDatabase();
  }

  void saveNewHabit() {
    setState(() {
      db.todaysHabitList.add([
        _newTaskController.text,
        _newDescirptionController.text,
        priority,
        false
      ]);
      db.updateDatabase();
    });

    _newTaskController.clear();
    _newDescirptionController.clear();
    Navigator.of(context).pop();
  }

  void cancelNewHabit() {
    _newTaskController.clear();
    _newDescirptionController.clear();
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  void checkBoxTapped(bool? value, int index) {
    setState(() {
      db.todaysHabitList[index][3] = value;
      db.updateDatabase();
    });
  }

  void saveExistingHabit(int index) {
    setState(() {
      db.todaysHabitList[index][0] = _newTaskController.text;
      db.todaysHabitList[index][1] = _newDescirptionController.text;
      

      db.updateDatabase();
    });
    _newTaskController.clear();
    _newDescirptionController.clear();
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  void openHabitSettings(int index) {
    showDialog(
        context: context,
        builder: (context) {
          return MyAlertDialog(
            onPriorityChange: (value) {
              setState(() {
                db.todaysHabitList[index][2] = value;
              });
            },
            priority: db.todaysHabitList[index][2],
            onSave: () => saveExistingHabit(index),
            onCancel: cancelNewHabit,
            titleController: _newTaskController,
            descriptionController: _newDescirptionController,
          );
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
        appBar: AppBar(
            backgroundColor: Colors.deepPurple,
            centerTitle: true,
            title: Text(
              "Daily Goal Tracker",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold, fontSize: 26),
            )),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey[200],
          onPressed: createNewHabit,
          child: const Icon(
            Icons.add,
            color: Colors.black,
            size: 24,
          ),
        ),
        backgroundColor: Colors.grey[900],
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
                    habitDescription: db.todaysHabitList[index][1],
                    priority: db.todaysHabitList[index][2],
                    isDone: db.todaysHabitList[index][3],
                    onChanged: (value) => checkBoxTapped(value, index),
                    deleteTapped: (context) => deleteHabit(index),
                    settingsTapped: (context) => openHabitSettings(index),
                  );
                })
          ],
        ));
  }
}
