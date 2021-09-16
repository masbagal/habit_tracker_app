import 'package:flutter_personal_tracker/model/task_entry.dart';
import 'package:flutter_personal_tracker/model/task_tracker.dart';
import 'package:hive_flutter/hive_flutter.dart';

late Box taskBox;
late Box taskTrackerBox;

Future initTaskBox() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskEntryAdapter());
  Hive.registerAdapter(TaskTrackerAdapter());
  taskBox = await Hive.openBox<TaskEntry>('taskBox2R');
  taskTrackerBox = await Hive.openBox<TaskTracker>('taskTrackerBox');

  // populate
  taskBox.put('123', TaskEntry.newTask(taskName: 'Peplayon', taskIcon: '😗'));
  taskBox.put(
      '124', TaskEntry.newTask(taskName: 'Muring-muring', taskIcon: '🤬'));
  taskBox.put(
      '125', TaskEntry.newTask(taskName: 'Ngoding', taskIcon: '🧑🏻‍💻'));

  List<DateTime> listPeplayon = [];
  listPeplayon.add(DateTime.now());
  listPeplayon.add(DateTime.now().subtract(Duration(days: 1)));
  listPeplayon.add(DateTime.now().subtract(Duration(days: 3)));

  TaskTracker dummyTracker = TaskTracker(trackedDates: listPeplayon);
  taskTrackerBox.put('123', dummyTracker);
  taskTrackerBox.put('124', dummyTracker);

  List<TaskEntry> sample = taskBox.values.toList() as List<TaskEntry>;
  sample.forEach((element) {
    print('------');
    print(element.taskName);
    print(element.taskIcon);
    print(element.taskStartDate);
  });
}
