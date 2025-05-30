import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../../../core/constants/storage_key.dart';
import '../../../data/services/preference_manager.dart';

class ProfileController extends ChangeNotifier {
  String username = '';
  String motivationQuote = 'One task at a time. One step closer.';
  String? userImagePath;
  bool isLoading = true;

  ProfileController() {
    _loadData();
  }

  Future<void> _loadData() async {
    username = PreferenceManager().getString(StorageKey.username) ?? '';
    motivationQuote = PreferenceManager().getString(StorageKey.motivationQuote) ?? motivationQuote;
    userImagePath = PreferenceManager().getString(StorageKey.userImage);
    isLoading = false;
    notifyListeners();
  }

  Future<void> saveImage(XFile file) async {
    final appDir = await getApplicationDocumentsDirectory();
    final newFile = await File(file.path).copy('${appDir.path}/${file.name}');
    userImagePath = newFile.path;
    PreferenceManager().setString(StorageKey.userImage, newFile.path);
    notifyListeners();
  }

  void updateProfile(String name, String quote) {
    username = name;
    motivationQuote = quote;
    notifyListeners();
  }

  Future<void> logout(BuildContext context, VoidCallback navigateToStartScreen) async {
     PreferenceManager().remove(StorageKey.username);
     PreferenceManager().remove(StorageKey.motivationQuote);
     PreferenceManager().remove(StorageKey.tasks);
    navigateToStartScreen();
  }
}
