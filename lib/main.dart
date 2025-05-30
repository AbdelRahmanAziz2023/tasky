import 'package:flutter/material.dart';
import 'package:tasky/core/constants/storage_key.dart';
import 'package:tasky/core/theme/dark_theme.dart';
import 'package:tasky/core/theme/light_theme.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/features/home/screens/start_screen.dart';

import 'data/services/preference_manager.dart';
import 'features/home/screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PreferenceManager().init();
  ThemeController().init();

  String? username = PreferenceManager().getString(StorageKey.username);

  runApp(MyApp(username: username));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.username});

  final String? username;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.notifier,
      builder: (context, ThemeMode themeMode, Widget? child) {
        return MaterialApp(
          title: 'Tasky App',
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeMode,
          home: username == null ? StartScreen() : MainScreen(),
        );
      },
    );
  }
}

/// PopupMenu
/// AlertDialog
/// Custom Dialog
/// ModalBottomSheet -> BottomSheet
/// DatePicker
/// FullScreen Dialog
