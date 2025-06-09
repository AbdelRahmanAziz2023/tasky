// task_controller.dart
import 'dart:convert';
import 'package:flutter/cupertino.dart';

import '../../../core/constants/storage_key.dart';
import '../../../data/models/task_model.dart';
import '../../../data/services/preference_manager.dart';

class TaskController with ChangeNotifier {
  List<TaskModel> completeTasks = [];
  List<TaskModel> todoTasks = [];
  List<TaskModel> tasks = [];

  bool isLoading = false;
  int totalTask = 0;
  int totalDoneTasks = 0;
  double percent = 0;

  Future<void> init() async {
    await loadTasks();
  }

  Future<void> loadTasks() async {
    isLoading = true;
    notifyListeners();

    final taskString = PreferenceManager().getString(StorageKey.tasks);
    if (taskString != null) {
      final taskList = (jsonDecode(taskString) as List<dynamic>)
          .map((e) => TaskModel.fromMap(e))
          .toList();

      tasks = taskList;
      todoTasks = taskList.where((task) => !task.isDone).toList();
      completeTasks = taskList.where((task) => task.isDone).toList();
      calculatePercent();
    }

    isLoading = false;
    notifyListeners();
  }

  void calculatePercent() {
    totalTask = tasks.length;
    totalDoneTasks = tasks.where((e) => e.isDone).length;
    percent = totalTask == 0 ? 0 : totalDoneTasks / totalTask;
  }

  Future<void> doneTask(bool? value, int index) async {
    tasks[index].isDone = value ?? false;
    await _persistAndReload();
  }

  Future<void> deleteTask(int id) async {
    tasks.removeWhere((task) => task.id == id);
    await _persistAndReload();
  }

  Future<void> editTask(TaskModel updatedTask) async {
    final index = tasks.indexWhere((t) => t.id == updatedTask.id);
    if (index != -1) {
      tasks[index] = updatedTask;
      await _persistAndReload();
    }
  }

  Future<void> toggleTaskStatus(
      int index,
      bool isDone,
      ) async {
    if (index < 0 || index >= tasks.length) return;

    tasks[index].isDone = isDone;
    await _persistAndReload();
  }

  Future<void> _persistAndReload() async {
    final updatedTask = tasks.map((task) => task.toMap()).toList();
    await PreferenceManager().setString(
      StorageKey.tasks,
      jsonEncode(updatedTask),
    );
    await loadTasks(); // refresh todo & complete lists
  }
}
