import 'package:flutter/material.dart';
import 'package:flutter_personal_tracker/components/task_card.dart';
import 'package:flutter_personal_tracker/constant.dart';
import 'package:flutter_personal_tracker/helpers/task_db.dart';
import 'package:flutter_personal_tracker/model/task_entry.dart';
import 'package:flutter_personal_tracker/screens/task_screen.dart';

class TaskList extends StatefulWidget {
  final DateTime selectedDate;
  final Function refreshHomePage;

  TaskList({required this.selectedDate, required this.refreshHomePage});

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  int id = 0;

  handleNavigation(int taskId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskScreen(
          taskId: taskId,
        ),
      ),
    ).then((value) {
      widget.refreshHomePage();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<TaskEntry> taskList = taskBox.values.toList() as List<TaskEntry>;

    List<Widget> renderTaskCard() {
      int index = 0;

      if (taskList.isNotEmpty) {
        return taskList.map((task) {
          int taskId = taskBox.keyAt(index++);
          return TaskCard(
            taskId: taskId,
            cardTitle: task.taskName,
            emojiIcon: task.taskIcon,
            selectedDate: widget.selectedDate,
            onTap: handleNavigation,
          );
        }).toList();
      } else {
        return [
          Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 48, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'No task(s) yet.',
                    style: kTextLight.copyWith(fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Add your first task by tapping add button on the bottom corner.',
                    style: kTextLight.copyWith(height: 1),
                    textAlign: TextAlign.center,
                  ),
                ],
              ))
        ];
      }
    }

    return Container(
      child: Column(children: renderTaskCard()),
    );
  }
}
