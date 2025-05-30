import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:tasky/core/constants/storage_key.dart';

import '../../../data/models/task_model.dart';
import '../../../data/services/preference_manager.dart';

class HomeController with ChangeNotifier {
  List<TaskModel> tasksList = [];
  String? username = "Default";
  String? userImagePath;
  List<TaskModel> tasks = [];
  bool isLoading = false;
  int totalTask = 0;
  int totalDoneTasks = 0;
  double percent = 0;


  init() {
    loadUserData();
    loadTask();
  }

  void loadUserData() async {
    username = PreferenceManager().getString(StorageKey.username);
    userImagePath = PreferenceManager().getString(StorageKey.userImage);

    notifyListeners();
  }

  void loadTask() async {
    isLoading = true;

    final finalTask = PreferenceManager().getString(StorageKey.tasks);
    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;

      tasks = taskAfterDecode.map((element) => TaskModel.fromMap(element)).toList();
      calculatePercent();
    }

    isLoading = false;

    notifyListeners();
  }

  calculatePercent() {
    totalTask = tasks.length;
    totalDoneTasks = tasks.where((e) => e.isDone).length;
    percent = totalTask == 0 ? 0 : totalDoneTasks / totalTask;
  }

  doneTask(bool? value, int? index) async {
    tasks[index!].isDone = value ?? false;
    calculatePercent();

    final updatedTask = tasks.map((element) => element.toMap()).toList();
    PreferenceManager().setString(StorageKey.tasks, jsonEncode(updatedTask));

    notifyListeners();
  }

  deleteTask(int? id) async {
    if (id == null) return;
    tasks.removeWhere((task) => task.id == id);
    calculatePercent();
    final updatedTask = tasks.map((element) => element.toMap()).toList();
    PreferenceManager().setString(StorageKey.tasks, jsonEncode(updatedTask));

    notifyListeners();
  }
}
