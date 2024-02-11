import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:habbit_tracker/data/habit_database.dart';

class MyAlertDialog extends StatelessWidget {
  final titleController;
  final descriptionController;
  final Priorities priority;
  final Function onPriorityChange;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  const MyAlertDialog(
      {Key? key,
      required this.titleController,
      required this.onSave,
      required this.onCancel,
      required this.descriptionController,
      required this.priority,
      required this.onPriorityChange(value)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[900],
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
                hintText: "Enter habit",
                hintStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white))),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(
                hintText: "Enter description",
                hintMaxLines: 4,
                hintStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white))),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(
            height: 20,
          ),
          DropdownButtonFormField(
            icon: const Icon(Icons.low_priority_rounded),
            value: priority,
            borderRadius: BorderRadius.circular(8),
            dropdownColor: Colors.grey[900],
            hint: const Text("Select priority",
                style: TextStyle(color: Colors.white)),
            items: Priorities.values
                .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e.toString().split('.')[1],
                        style: const TextStyle(color: Colors.white))))
                .toList(),
            onChanged: (value) {
              onPriorityChange(value);
              SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {});
            },
          ),
        ],
      ),
      actions: [
        ElevatedButton(
            onPressed: onSave,
            child: const Text(
              "Save",
              style: TextStyle(color: Colors.deepPurple),
            )),
        ElevatedButton(
            onPressed: onCancel,
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.red),
            ))
      ],
    );
  }
}
