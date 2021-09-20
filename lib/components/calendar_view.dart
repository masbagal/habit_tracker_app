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
      this.isDone = false});

  @override
  Widget build(BuildContext context) {
    final dayText = DateFormat.d().format(day);
    final color = isDisabled ? Colors.white30 : Colors.white70;
    final isShowCheckmark = isDone && !isDisabled;
    Color boxColor = Colors.transparent;
    if (isSelected && isShowCheckmark) {
      boxColor = Color(0xff1b5e20);
    } else if (isSelected) {
      boxColor = Color(0xff904E95);
    } else if (isShowCheckmark) {
      boxColor = Colors.green;
    }

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
  final DateTime? firstDate;

  CalendarView(
      {required this.monthTrackingData,
      required this.onSelectedDateChanged,
      this.firstDate});

  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final month = DateFormat.yMMMM().format(_selectedDay);
    return Column(
      children: [
        Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            month,
            style: kTextBold,
          ),
        ),
        SizedBox(height: 24),
        TableCalendar(
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay; // update `_focusedDay` here as well
              widget.onSelectedDateChanged(selectedDay);
            });
          },
          onFormatChanged: (format) {
            print(format);
          },
          headerVisible: false,
          rangeSelectionMode: RangeSelectionMode.disabled,
          calendarBuilders: CalendarBuilders(
            headerTitleBuilder: (context, datetime) {
              final month = DateFormat.yMMM().format(datetime);
              return Text(month, style: kText);
            },
            todayBuilder: (context, day, focusedDay) {
              return DateCell(
                day: day,
                isSelected: isSameDay(_selectedDay, day),
                isDone: widget.monthTrackingData.checkIsDoneWhereDate(day),
              );
            },
            selectedBuilder: (context, day, focusedDay) {
              return DateCell(
                  day: day,
                  isDisabled: true,
                  isDone: widget.monthTrackingData.checkIsDoneWhereDate(day));
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
          firstDay: widget.firstDate != null
              ? widget.firstDate!.subtract(Duration(days: 5))
              : DateTime.now(),
          lastDay: DateTime.now().add(Duration(days: 90)),
          focusedDay: DateTime.now(),
          headerStyle:
              HeaderStyle(titleTextStyle: TextStyle(color: Colors.white)),
          availableGestures: AvailableGestures.horizontalSwipe,
        ),
      ],
    );
  }
}
