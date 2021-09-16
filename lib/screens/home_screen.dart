import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_personal_tracker/components/hero_banner.dart';
import 'package:flutter_personal_tracker/components/lists/task_list.dart';
import 'package:flutter_personal_tracker/components/task_card.dart';
import 'package:flutter_personal_tracker/screens/add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddTaskScreen(),
              ),
            ).then((value) {
              setState(() {});
            });
          },
          elevation: 20,
          backgroundColor: Colors.teal,
          child: Icon(Icons.add)),
      backgroundColor: Color(0x11162130),
      body: SafeArea(
        top: false,
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeroBanner(),
              SizedBox(height: 12),
              Container(
                  padding: EdgeInsets.only(left: 24, right: 24, bottom: 48),
                  margin: EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    children: [
                      // static const double dateTextSize = 24;
                      // static const double dayTextSize = 11;
                      // static const double monthTextSize = 11;
                      Padding(
                        padding: const EdgeInsets.only(bottom: 24, top: 8),
                        child: DatePicker(
                          DateTime.now().subtract(Duration(days: 4)),
                          daysCount: 5,
                          initialSelectedDate: DateTime.now(),
                          selectionColor: Color(0xff904E95),
                          selectedTextColor: Colors.white,
                          dateTextStyle:
                              TextStyle(fontSize: 24, color: Colors.white38),
                          monthTextStyle:
                              TextStyle(fontSize: 11, color: Colors.white38),
                          dayTextStyle:
                              TextStyle(fontSize: 11, color: Colors.white38),
                          onDateChange: (date) {
                            setState(() {
                              selectedDate = date;
                            });
                          },
                        ),
                      ),
                      TaskList(
                        selectedDate: selectedDate,
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
