// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_tracker.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskTrackerAdapter extends TypeAdapter<TaskTracker> {
  @override
  final int typeId = 1;

  @override
  TaskTracker read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskTracker(
      trackedDates: (fields[0] as List).cast<DateTime>(),
    );
  }

  @override
  void write(BinaryWriter writer, TaskTracker obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.trackedDates);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskTrackerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
