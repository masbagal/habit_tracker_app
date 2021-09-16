import 'package:flutter/material.dart';
import 'package:flutter_personal_tracker/components/task_card.dart';
import 'package:flutter_personal_tracker/helpers/task_db.dart';
import 'package:flutter_personal_tracker/model/task_entry.dart';
import 'package:flutter_personal_tracker/screens/task_screen.dart';

class TaskList extends StatefulWidget {
  final DateTime selectedDate;

  TaskList({required this.selectedDate});

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  int id = 0;

  handleNavigation(String taskId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskScreen(
          taskId: taskId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<TaskEntry> taskList = taskBox.values.toList() as List<TaskEntry>;

    List<Widget> renderTaskCard() {
      int index = 0;
      return taskList.map((task) {
        String taskId = taskBox.keyAt(index++);
        return TaskCard(
          taskId: taskId,
          cardTitle: task.taskName,
          emojiIcon: task.taskIcon,
          selectedDate: widget.selectedDate,
          onTap: handleNavigation,
        );
      }).toList();
    }

    return Container(
      child: Column(children: renderTaskCard()),
    );
  }
}
