import 'package:flutter/material.dart';
import 'package:flutter_personal_tracker/components/calendar_view.dart';
import 'package:flutter_personal_tracker/constant.dart';
import 'package:flutter_personal_tracker/helpers/task_db.dart';
import 'package:flutter_personal_tracker/model/task_entry.dart';
import 'package:flutter_personal_tracker/model/task_tracker.dart';
import 'package:intl/intl.dart';

class TaskScreen extends StatefulWidget {
  final String taskId;

  TaskScreen({required this.taskId});

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final dateDisplay = DateFormat.yMMMMd().format(selectedDate);
    TaskEntry task = taskBox.get(widget.taskId);
    TaskTracker taskTracker = taskTrackerBox.get(widget.taskId,
        defaultValue: TaskTracker(trackedDates: []));

    bool isSelectedDayTaskDone = taskTracker.checkIsDoneWhereDate(selectedDate);

    return Scaffold(
      backgroundColor: Color(0x11162130),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isSelectedDayTaskDone
                ? [Color(0xff3E9450), Color(0x003E9450)]
                : [Color(0xff904E95), Color(0x00904E95)],
            begin: Alignment.topRight,
            end: Alignment(0.5, -0.4),
          ),
        ),
        child: SafeArea(
            bottom: false,
            top: false,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 30, left: 32, right: 40),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          Icon(Icons.chevron_left, color: Colors.white),
                          Text(
                            'Back',
                            style: kText,
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 40, left: 40, right: 40),
                    child: Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        Opacity(
                          opacity: 0.45,
                          child: Container(
                            child: Text(
                              task.taskIcon,
                              style:
                                  TextStyle(fontSize: 64, color: Colors.white),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(dateDisplay, style: kHeroSubTitleStyle),
                                isSelectedDayTaskDone
                                    ? Container(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 8),
                                        child: Icon(
                                          Icons.circle,
                                          size: 8,
                                          color: Colors.white,
                                        ),
                                      )
                                    : Container(),
                                isSelectedDayTaskDone
                                    ? Text(
                                        'DONE',
                                        style: TextStyle(
                                            color: Colors.greenAccent,
                                            fontSize: 16),
                                      )
                                    : Container(),
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(task.taskName, style: kTaskTitleText),
                            SizedBox(height: 24),
                            Divider(
                              color: Colors.white,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Completed',
                              style: kTextLight,
                            ),
                            Text(
                              '12 times',
                              style: kTextBold,
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Longest Streak',
                              style: kTextLight,
                            ),
                            Text(
                              '5 streaks',
                              style: kTextBold,
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                        CalendarView(
                          monthTrackingData: taskTracker,
                          onSelectedDateChanged: (DateTime date) {
                            setState(() {
                              selectedDate = date;
                            });
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
