import 'package:hive/hive.dart';

part 'task_entry.g.dart';

@HiveType(typeId: 0)
class TaskEntry {
  TaskEntry({
    required this.taskName,
    required this.taskIcon,
    this.taskStartDate,
  });

  TaskEntry.newTask({
    required this.taskName,
    required this.taskIcon,
  }) : taskStartDate = DateTime.now();

  @HiveField(0)
  late String taskName;
  @HiveField(1)
  late String taskIcon;
  @HiveField(2)
  DateTime? taskStartDate = DateTime.now();
}
