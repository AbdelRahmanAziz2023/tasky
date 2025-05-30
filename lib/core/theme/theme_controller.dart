import 'package:flutter/material.dart';
import 'package:tasky/core/constants/storage_key.dart';

import '../../data/services/preference_manager.dart';

class ThemeController {
  static final ValueNotifier<ThemeMode> notifier = ValueNotifier(ThemeMode.dark);

  init() {
    bool result = PreferenceManager().getBool(StorageKey.theme) ?? true;
    notifier.value = result ? ThemeMode.dark : ThemeMode.light;
  }

  static toggleTheme() async {
    if (notifier.value == ThemeMode.dark) {
      notifier.value = ThemeMode.light;
      await PreferenceManager().setBool(StorageKey.theme, false);
    } else {
      notifier.value = ThemeMode.dark;
      await PreferenceManager().setBool(StorageKey.theme, true);
    }
  }

  static bool isDark() => notifier.value == ThemeMode.dark;
}
