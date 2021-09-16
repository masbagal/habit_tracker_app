import 'package:flutter/material.dart';
import 'package:flutter_personal_tracker/model/task_tracker.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../constant.dart';

class DateCell extends StatelessWidget {
  final DateTime day;
  final bool isDone;
  final bool isDisabled;
  final bool isSelected;

  DateCell(
      {required this.day,
      this.isDisabled = false,
      this.isSelected = false,
      this.isDone = true});

  @override
  Widget build(BuildContext context) {
    final dayText = DateFormat.d().format(day);
    final color = isDisabled ? Colors.white30 : Colors.white70;
    final isShowCheckmark = isDone && !isDisabled;
    final boxColor = isSelected
        ? Color(0xff904E95)
        : isShowCheckmark
            ? Colors.green
            : Colors.transparent;
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: boxColor,
      ),
      child: Text(dayText, style: kText.copyWith(color: color)),
    );
  }
}

class CalendarView extends StatefulWidget {
  final TaskTracker monthTrackingData;
  final onSelectedDateChanged;

  CalendarView(
      {required this.monthTrackingData, required this.onSelectedDateChanged});

  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay; // update `_focusedDay` here as well
          widget.onSelectedDateChanged(selectedDay);
        });
      },
      calendarBuilders: CalendarBuilders(
        headerTitleBuilder: (context, datetime) {
          final month = DateFormat.yMMM().format(datetime);
          return Text(month, style: kText);
        },
        todayBuilder: (context, day, focusedDay) {
          return DateCell(
            day: day,
            isSelected: isSameDay(_selectedDay, day),
          );
        },
        selectedBuilder: (context, day, focusedDay) {
          return DateCell(day: day, isDisabled: true);
        },
        disabledBuilder: (context, day, focusedDay) {
          return DateCell(day: day, isDisabled: true);
        },
        outsideBuilder: (context, day, focusedDay) {
          return DateCell(day: day, isDisabled: true);
        },
        defaultBuilder: (context, day, focusedDay) {
          return DateCell(
              day: day,
              isSelected: isSameDay(_selectedDay, day),
              isDone: widget.monthTrackingData.checkIsDoneWhereDate(day));
        },
        dowBuilder: (context, day) {
          final text = DateFormat.E().format(day);
          final bool isWeekday = day.weekday == DateTime.sunday;
          final color = isWeekday ? Colors.red : Colors.white70;

          return Center(
            child: Text(
              text,
              style: TextStyle(color: color),
            ),
          );
        },
      ),
      firstDay: DateTime.utc(2021, 9, 1),
      lastDay: DateTime.now(),
      focusedDay: DateTime.now(),
    );
  }
}
