// home_controller.dart
import 'package:flutter/cupertino.dart';
import '../../../core/constants/storage_key.dart';
import '../../../data/services/preference_manager.dart';
import '../../../data/models/task_model.dart';
import '../../tasks/controller/task_controller.dart';

class HomeController with ChangeNotifier {
  String? username = "Default";
  String? userImagePath;
  bool isLoading = false;

   TaskController taskController;

  HomeController(this.taskController);

  init() {
    loadUserData();
    taskController.init();
  }

  void loadUserData() async {
    username = PreferenceManager().getString(StorageKey.username);
    userImagePath = PreferenceManager().getString(StorageKey.userImage);
    notifyListeners();
  }

  void doneTask(bool? value, int index) async {
    await taskController.doneTask(value, index);
  }

  void deleteTask(int id) async {
    await taskController.deleteTask(id);
  }

  void editTask(TaskModel updatedTask) async {
    await taskController.editTask(updatedTask);
  }
}
