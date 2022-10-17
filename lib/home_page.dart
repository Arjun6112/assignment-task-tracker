import 'package:flutter/material.dart';
import 'package:habbit_tracker/components/habit_tile.dart';

import 'components/my_alert_dialog.dart';
import 'components/floating_action_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List todaysHabitList = [
    ["100 Pushups", false],
    ["Morning Run", false],
    ["Walk the dog", false],
    ["Leetcode 3 questions", false],
    ["Flutter tutorials", false],
  ];
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
  }

  void saveNewHabit() {
    setState(() {
      todaysHabitList.add([_newHabitController.text, false]);
    });

    _newHabitController.clear();
    Navigator.of(context).pop();
  }

  void cancelNewHabit() {
    _newHabitController.clear();
    Navigator.of(context).pop();
  }

  void checkBoxTapped(bool? value, int index) {
    setState(() {
      todaysHabitList[index][1] = value;
    });
  }

  void saveExistingHabit(int index) {
    setState(() {
      todaysHabitList[index][0] = _newHabitController.text;
    });
    _newHabitController.clear();
    Navigator.of(context).pop();
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
  }

  void deleteHabit(int index) {
    setState(() {
      todaysHabitList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: MyFloatingActionButton(
          onPressed: createNewHabit,
        ),
        backgroundColor: Colors.grey[300],
        body: ListView.builder(
            itemCount: todaysHabitList.length,
            itemBuilder: (context, index) {
              return HabitTile(
                habitName: todaysHabitList[index][0],
                isDone: todaysHabitList[index][1],
                onChanged: (value) => checkBoxTapped(value, index),
                deleteTapped: (context) => deleteHabit(index),
                settingsTapped: (context) => openHabitSettings(index),
              );
            }));
  }
}
