import 'package:hive/hive.dart';

part 'task_tracker.g.dart';

@HiveType(typeId: 1)
class TaskTracker {
  @HiveField(0)
  late List<DateTime> trackedDates;

  TaskTracker({required this.trackedDates});

  List<DateTime> findAtMonth({required int month, required int year}) {
    return trackedDates
        .where((date) => date.month == month && date.year == year)
        .toList();
  }

  bool checkIsDoneWhereDate(DateTime date) {
    int indexOfTrackedDate = trackedDates.indexWhere((storedDate) {
      bool isYearMatched = date.year == storedDate.year;
      bool isMonthMatched = date.month == storedDate.month;
      bool isDayMatched = date.day == storedDate.day;

      return isYearMatched && isMonthMatched && isDayMatched;
    });

    bool isDateTracked = indexOfTrackedDate >= 0;
    return isDateTracked;
  }

  bool isTodayTaskDone() {
    return checkIsDoneWhereDate(DateTime.now());
  }

  void addDateEntry(DateTime date) {
    trackedDates.add(date);
  }

  void removeDateEntry(DateTime date) {
    int removedIndex = trackedDates.indexWhere((storedDate) {
      bool isYearMatched = date.year == storedDate.year;
      bool isMonthMatched = date.month == storedDate.month;
      bool isDayMatched = date.day == storedDate.day;

      return isYearMatched && isMonthMatched && isDayMatched;
    });

    trackedDates.removeAt(removedIndex);
  }
}
