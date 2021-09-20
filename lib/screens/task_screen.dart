import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter_personal_tracker/components/calendar_view.dart';
import 'package:flutter_personal_tracker/constant.dart';
import 'package:flutter_personal_tracker/helpers/task_db.dart';
import 'package:flutter_personal_tracker/model/task_entry.dart';
import 'package:flutter_personal_tracker/model/task_tracker.dart';
import 'package:intl/intl.dart';

class TaskScreen extends StatefulWidget {
  final int taskId;

  TaskScreen({required this.taskId});

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  late ConfettiController _confettiController;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: Duration(milliseconds: 400));
  }

  @override
  void dispose() {
    super.dispose();
    _confettiController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dateDisplay = DateFormat.yMMMMd().format(selectedDate);
    TaskEntry task = taskBox.get(widget.taskId);
    TaskTracker taskTracker = taskTrackerBox.get(widget.taskId,
        defaultValue: TaskTracker(trackedDates: []));

    int totalCompletedTimes = taskTracker.trackedDates.length;
    bool isSelectedDayTaskDone = taskTracker.checkIsDoneWhereDate(selectedDate);
    Duration durationSinceStart =
        DateTime.now().difference(task.taskStartDate!);
    int daysSinceStart = durationSinceStart.inDays + 1;

    void handleMarkAsDone() {
      _confettiController.play();
      taskTracker.addDateEntry(selectedDate);
      taskTrackerBox.put(widget.taskId, taskTracker);
      setState(() {});
    }

    void removeDoneMark() {
      taskTracker.removeDateEntry(selectedDate);
      taskTrackerBox.put(widget.taskId, taskTracker);
      setState(() {});
    }

    return Scaffold(
      backgroundColor: Color(0x77162130),
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
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirectionality: BlastDirectionality.explosive,
                  colors: const [
                    Colors.green,
                    Colors.blue,
                    Colors.pink,
                    Colors.orange,
                    Colors.purple
                  ], // manually specify the colors to be used
                ),
              ),
              SingleChildScrollView(
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
                                style: TextStyle(
                                    fontSize: 64, color: Colors.white),
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
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8),
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
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Completed',
                                style: kTextLight,
                              ),
                              Text(
                                '$totalCompletedTimes times from $daysSinceStart',
                                style: kTextBold,
                              ),
                            ],
                          ),
                          SizedBox(height: 36),
                          CalendarView(
                            firstDate: task.taskStartDate,
                            monthTrackingData: taskTracker,
                            onSelectedDateChanged: (DateTime date) {
                              setState(() {
                                selectedDate = date;
                              });
                            },
                          ),
                          SizedBox(height: 48),
                          RawMaterialButton(
                            fillColor: isSelectedDayTaskDone
                                ? Colors.grey[800]
                                : Colors.green[900],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            onPressed: isSelectedDayTaskDone
                                ? removeDoneMark
                                : handleMarkAsDone,
                            autofocus: false,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: isSelectedDayTaskDone
                                  ? Text(
                                      'Mark as not done',
                                      style: kTextBold,
                                    )
                                  : Text(
                                      'Mark as done',
                                      style: kTextBold,
                                    ),
                            ),
                          ),
                          SizedBox(height: 48),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
