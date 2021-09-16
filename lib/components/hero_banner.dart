import 'package:flutter/material.dart';
import 'package:flutter_personal_tracker/helpers/task_db.dart';
import 'package:flutter_personal_tracker/model/task_tracker.dart';
import 'package:intl/intl.dart';

import '../constant.dart';

class ClipPathClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width, size.height * 0.75);
    path.lineTo(0.0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class HeroBanner extends StatelessWidget {
  final weekday = DateFormat.EEEE().format(DateTime.now()) + ',';
  final date = DateFormat.yMMMMd().format(DateTime.now());

  int countTotalTasks() {
    return taskBox.keys.length;
  }

  int countTaskDoneCount() {
    int count = 0;
    taskTrackerBox.keys.forEach((taskId) {
      TaskTracker tracker = taskTrackerBox.get(taskId,
          defaultValue: TaskTracker(trackedDates: []));
      if (tracker.isTodayTaskDone()) {
        count += 1;
      }
    });
    return count;
  }

  @override
  Widget build(BuildContext context) {
    int totalTasks = countTotalTasks();
    int totalDoneTaskToday = countTaskDoneCount();
    return Container(
      height: MediaQuery.of(context).size.height * 0.40,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          ClipPath(
            clipper: ClipPathClass(),
            child: SizedBox(
                child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment(-1, 0.1),
                  colors: <Color>[
                    Color(0xff904E95),
                    Color(0xff141E30)
                  ], // red to yellow/ repeats the gradient over the canvas
                ),
              ),
            )),
          ),
          Container(
            transform: Matrix4.translationValues(16, 8, 0),
            padding: EdgeInsets.only(top: 36),
            alignment: Alignment.bottomRight,
            child: Image.asset('assets/hero1.png'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Today:', style: kTextLight),
                Text(weekday, style: kHeroTextStyle),
                Text(date, style: kHeroTextStyle),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text('$totalDoneTaskToday of $totalTasks tasks done',
                      style: kHeroSubTitleStyle),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
