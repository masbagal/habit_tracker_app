// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskEntryAdapter extends TypeAdapter<TaskEntry> {
  @override
  final int typeId = 0;

  @override
  TaskEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskEntry(
      taskName: fields[0] as String,
      taskIcon: fields[1] as String,
      taskStartDate: fields[2] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, TaskEntry obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.taskName)
      ..writeByte(1)
      ..write(obj.taskIcon)
      ..writeByte(2)
      ..write(obj.taskStartDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
