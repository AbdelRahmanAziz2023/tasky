import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/task_item.dart';
import '../models/task_model.dart';

class CompleteScreen extends StatefulWidget {
  const CompleteScreen({super.key});

  @override
  State<CompleteScreen> createState() => _CompleteScreenState();
}

class _CompleteScreenState extends State<CompleteScreen> {
  List<TaskModel> tasks = [];

  void getTasks() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    final String? list = pref.getString('tasks');

    List<dynamic> decodedList = [];
    if (list != null) {
      decodedList = jsonDecode(list);
    }

    tasks = decodedList.map((e) => TaskModel.fromMap(e)).toList();
    print(tasks);
  }

  @override
  void initState() {
    super.initState();
    getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Completed Tasks')),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              SizedBox(height: 52),

              SizedBox(
                height: 300,
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (BuildContext context, int index) {
                    return TaskItem(checked: true, task: tasks[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
