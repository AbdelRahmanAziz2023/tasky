import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/constants/storage_key.dart';

import '../../../data/models/task_model.dart';
import '../../../data/services/preference_manager.dart';
import '../../../widgets/task_list_widget.dart';

class HighPriorityScreen extends StatefulWidget {
  const HighPriorityScreen({super.key});

  @override
  State<HighPriorityScreen> createState() => _HighPriorityScreenState();
}

class _HighPriorityScreenState extends State<HighPriorityScreen> {
  List<TaskModel> highPriorityTasks = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    _loadTask();
  }

  void _loadTask() async {
    setState(() {
      isLoading = true;
    });
    final finalTask = PreferenceManager().getString(StorageKey.tasks);
    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;
      setState(() {
        highPriorityTasks = taskAfterDecode
            .map((element) => TaskModel.fromMap(element))
            .where((element) => element.isHighPriority)
            .toList();

        highPriorityTasks = highPriorityTasks.reversed.toList();
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  _deleteTask(int? id) async {
    List<TaskModel> tasks = [];
    if (id == null) return;

    final finalTask = PreferenceManager().getString(StorageKey.tasks);
    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;
      tasks = taskAfterDecode.map((element) => TaskModel.fromMap(element)).toList();
      tasks.removeWhere((e) => e.id == id);

      setState(() {
        highPriorityTasks.removeWhere((task) => task.id == id);
      });

      final updatedTask = tasks.map((element) => element.toMap()).toList();
      PreferenceManager().setString(StorageKey.tasks, jsonEncode(updatedTask));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('High Priority Tasks'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : TaskListWidget(
                tasks: highPriorityTasks,
                onTap: (value, index) async {
                  setState(() {
                    highPriorityTasks[index!].isDone = value ?? false;
                  });

                  final allData = PreferenceManager().getString(StorageKey.tasks);

                  if (allData != null) {
                    List<TaskModel> allDataList =
                        (jsonDecode(allData) as List).map((element) => TaskModel.fromMap(element)).toList();

                    final int newIndex = allDataList.indexWhere((e) => e.id == highPriorityTasks[index!].id);
                    allDataList[newIndex] = highPriorityTasks[index!];

                    await PreferenceManager().setString(StorageKey.tasks, jsonEncode(allDataList));
                    _loadTask();
                  }
                },
                emptyMessage: 'No Task Found',
                onDelete: (int? id) {
                  _deleteTask(id);
                },
                onEdit: () {
                  _loadTask();
                },
              ),
      ),
    );
  }
}
