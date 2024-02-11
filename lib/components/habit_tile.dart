import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habbit_tracker/data/habit_database.dart';

class HabitTile extends StatelessWidget {
  final String habitName;
  final String habitDescription;
  final Priorities priority;

  final bool isDone;
  final Function(bool?)? onChanged;
  final Function(BuildContext?) deleteTapped;
  final Function(BuildContext?) settingsTapped;

  const HabitTile(
      {Key? key,
      required this.habitName,
      required this.isDone,
      required this.onChanged,
      required this.deleteTapped,
      required this.settingsTapped,
      required this.habitDescription,
      required this.priority})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Slidable(
        endActionPane: ActionPane(motion: const StretchMotion(), children: [
          SlidableAction(
            onPressed: settingsTapped,
            backgroundColor: Colors.grey.shade800,
            icon: Icons.mode_edit,
            borderRadius: BorderRadius.circular(12),
          ),
          SlidableAction(
            onPressed: deleteTapped,
            backgroundColor: Colors.red,
            icon: Icons.delete,
            borderRadius: BorderRadius.circular(12),
          )
        ]),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
              color: Colors.grey[300], borderRadius: BorderRadius.circular(8)),
          child: ListTile(
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(6),
                      color: Priorities.Normal == priority
                          ? Colors.green
                          : Priorities.Urgent == priority
                              ? Colors.red
                              : Colors.orange),
                  width: 30,
                  height: 30,
                ),
                Text(
                  priority.toString().split('.').last,
                  style: GoogleFonts.poppins(
                      fontSize: 12, fontWeight: FontWeight.bold),
                )
              ],
            ),
            trailing: Checkbox(value: isDone, onChanged: onChanged),
            title: Text(
              habitName,
              style: GoogleFonts.poppins(
                  fontSize: 20, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              habitDescription,
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ),
    );
  }
}
