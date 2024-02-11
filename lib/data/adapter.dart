import 'package:habbit_tracker/data/habit_database.dart';
import 'package:hive/hive.dart';

class PrioritiesAdapter extends TypeAdapter<Priorities> {
  @override
  final typeId = 1; // choose an unique id for this adapter

  @override
  Priorities read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Priorities.Normal;
      case 1:
        return Priorities.Important;
      case 2:
        return Priorities.Urgent;
      default:
        return Priorities.Normal;
    }
  }

  @override
  void write(BinaryWriter writer, Priorities obj) {
    switch (obj) {
      case Priorities.Normal:
        writer.writeByte(0);
        break;
      case Priorities.Important:
        writer.writeByte(1);
        break;
      case Priorities.Urgent:
        writer.writeByte(2);
        break;
    }
  }
}
