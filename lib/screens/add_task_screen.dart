import 'package:flutter/material.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter_personal_tracker/constant.dart';
import 'package:flutter_personal_tracker/components/task_card.dart';
import 'package:flutter_personal_tracker/helpers/task_db.dart';
import 'package:flutter_personal_tracker/model/task_entry.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  String taskName = '';
  String taskIcon = '🎗';
  bool showEmojiPicker = false;

  saveNewTask() {
    taskBox.add(TaskEntry(
      taskName: taskName,
      taskIcon: taskIcon,
      taskStartDate: DateTime.now(),
    ));

    setState(() {
      taskName = '';
      taskIcon = '🎗';
      showEmojiPicker = false;
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    bool isAbleToSubmit = taskName.length > 0;
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text('Add New Task'),
        backgroundColor: Color(0xff904E95),
      ),
      backgroundColor: Color(0x11162130),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 56),
                    child: Column(
                      children: [
                        RawTaskCard(
                          cardTitle: taskName.length > 0 ? taskName : '---',
                          emojiIcon: taskIcon,
                        ),
                        SizedBox(height: 12),
                        Text(
                          'This is a preview of your task card',
                          style: kTextLight,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            autofocus: true,
                            cursorColor: Colors.purple,
                            onChanged: (value) {
                              setState(() {
                                taskName = value;
                              });
                            },
                            maxLength: 30,
                            decoration: InputDecoration(
                                fillColor: Colors.red,
                                focusColor: Colors.red,
                                labelText: 'Task Name',
                                labelStyle: TextStyle(
                                  color: Colors.purple[100],
                                )),
                            style: kText.copyWith(fontSize: 24),
                          ),
                          SizedBox(height: 24),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Task Icon',
                              style: kText.copyWith(
                                  fontSize: 24, color: Colors.purple[100]),
                            ),
                          ),
                          SizedBox(height: 24),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                showEmojiPicker = true;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.purple[800]?.withOpacity(0.4),
                              ),
                              child: Text(
                                taskIcon,
                                style: TextStyle(fontSize: 32),
                              ),
                            ),
                          ),
                          SizedBox(height: 24),
                          Divider(
                            color: Colors.purple[200],
                          ),
                          SizedBox(height: 24),
                          RawMaterialButton(
                            fillColor: isAbleToSubmit
                                ? Colors.green[900]
                                : Colors.blueGrey.withOpacity(0.2),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            onPressed: () {
                              if (isAbleToSubmit) {
                                saveNewTask();
                              }
                            },
                            clipBehavior: Clip.none,
                            autofocus: false,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text('Submit',
                                  style: kText.copyWith(
                                    fontSize: 18,
                                    color: isAbleToSubmit
                                        ? Colors.white
                                        : Colors.white30,
                                  )),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Offstage(
                offstage: !showEmojiPicker,
                child: SizedBox(
                  height: 250,
                  child: EmojiPicker(
                      onEmojiSelected: (Category category, Emoji emoji) {
                        print(emoji);
                        setState(() {
                          taskIcon = emoji.emoji;
                          showEmojiPicker = false;
                        });
                      },
                      config: Config(
                          columns: 5,
                          // Issue: https://github.com/flutter/flutter/issues/28894
                          emojiSizeMax: 32,
                          verticalSpacing: 0,
                          horizontalSpacing: 0,
                          bgColor: const Color(0xff141E30),
                          indicatorColor: Colors.purple,
                          iconColor: Colors.grey,
                          iconColorSelected: Colors.purpleAccent,
                          progressIndicatorColor: Colors.blue,
                          backspaceColor: Colors.blue,
                          showRecentsTab: true,
                          recentsLimit: 28,
                          noRecentsText: 'No Recents',
                          noRecentsStyle: const TextStyle(
                              fontSize: 20, color: Colors.black26),
                          tabIndicatorAnimDuration: kTabScrollDuration,
                          categoryIcons: const CategoryIcons(),
                          buttonMode: ButtonMode.MATERIAL)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
