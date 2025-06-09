import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/widgets/custom_text_form_field.dart';

import '../../../data/models/task_model.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final GlobalKey<FormState> _key = GlobalKey();

  final TextEditingController taskNameController = TextEditingController();

  final TextEditingController taskDescriptionController =
      TextEditingController();

  bool isHighPriority = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Task')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 8),
                CustomTextFormField(
                  name: 'Task Name',
                  hintText: 'Finish UI design for login screen',
                  controller: taskNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter task name';
                    }
                  },
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                  name: 'Task Description',
                  hintText:
                      'Finish onboarding UI and hand off to devs by Thursday.',
                  controller: taskDescriptionController,
                  maxLines: 6,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'High Priority',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    Switch(
                      value: isHighPriority,
                      onChanged: (value) {
                        setState(() {
                          isHighPriority = value;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 100),
                ElevatedButton.icon(
                  onPressed: () async {
                    if (_key.currentState?.validate() ?? false) {
                      final SharedPreferences pref =
                          await SharedPreferences.getInstance();

                      var tasks = pref.getString('tasks');
                      List<dynamic> tasksList = [];
                      if (tasks != null) {
                        tasksList = jsonDecode(tasks);
                      }

                      final TaskModel task = TaskModel(
                        id: tasksList.length + 1,
                        title: taskNameController.text,
                        description: taskDescriptionController.text,
                        isHighPriority: isHighPriority,
                      );

                      tasksList.add(task.toMap());

                      await pref.setString('tasks', jsonEncode(tasksList));

                      taskNameController.clear();
                      taskDescriptionController.clear();

                      Navigator.pop(context, true);
                    }
                  },
                  label: Text('Add New Task'),
                  icon: Icon(Icons.add),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
