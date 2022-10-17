import 'package:flutter/material.dart';

class MyAlertDialog extends StatelessWidget {
  final controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  const MyAlertDialog(
      {Key? key,
      required this.controller,
      required this.onSave,
      required this.onCancel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[900],
      content: TextField(
        controller: controller,
        decoration: InputDecoration(
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white))),
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        MaterialButton(
            onPressed: onSave,
            color: Colors.black,
            child: const Text(
              "Save",
              style: TextStyle(color: Colors.white),
            )),
        MaterialButton(
            onPressed: onCancel,
            color: Colors.black,
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.white),
            ))
      ],
    );
  }
}
