import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../../core/constants/storage_key.dart';
import '../../../data/models/task_model.dart';
import '../../../data/services/preference_manager.dart';

class TaskController extends ChangeNotifier {
  List<TaskModel> completeTasks = [];
  List<TaskModel> todoTasks = [];

  bool isLoading = false;

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

      todoTasks = taskList.where((task) => !task.isDone).toList();
      completeTasks = taskList.where((task) => task.isDone).toList();
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> deleteTask(int id) async {
    final taskString = PreferenceManager().getString(StorageKey.tasks);
    if (taskString != null) {
      final taskList = (jsonDecode(taskString) as List<dynamic>)
          .map((e) => TaskModel.fromMap(e))
          .toList();

      taskList.removeWhere((task) => task.id == id);
      await PreferenceManager().setString(
        StorageKey.tasks,
        jsonEncode(taskList),
      );

      await loadTasks(); // reload
    }
  }

  Future<void> toggleTaskStatus(
    int index,
    bool isDone,
    String storageKey,
  ) async {
    final taskString = PreferenceManager().getString(storageKey);
    if (taskString != null) {
      final taskList = (jsonDecode(taskString) as List<dynamic>)
          .map((e) => TaskModel.fromMap(e))
          .toList();

      final task = completeTasks[index];
      final idxInMainList = taskList.indexWhere((e) => e.id == task.id);

      if (idxInMainList != -1) {
        taskList[idxInMainList] = TaskModel(
          id: task.id,
          title: task.title,
          description: task.description,
          isHighPriority: task.isHighPriority,
        )..isDone = isDone;

        await PreferenceManager().setString(storageKey, jsonEncode(taskList));
        await loadTasks();
      }
    }
  }
}
