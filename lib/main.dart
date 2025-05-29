import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/core/Screens/main_screen.dart';

import 'core/Screens/start_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final SharedPreferences pref = await SharedPreferences.getInstance();

  String? name = pref.getString('username');

  // pref.clear();
  runApp(MyApp(name: name));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.name});

  final String? name;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tasky App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type:BottomNavigationBarType.fixed ,
          backgroundColor: Color(0xFF181818),
          showUnselectedLabels: true,
          unselectedItemColor: Color(0xFFC6C6C6),
          selectedItemColor: Color(0xFF15B86C),
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
          unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
        iconTheme: IconThemeData(
          color:Color(0xFFFFFCFC),
        ),
        scaffoldBackgroundColor: Color(0xFF181818),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF181818),
          titleTextStyle:TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Color(0xFFFFFCFC),
          ),
          iconTheme: IconThemeData(
            color: Color(0xFFFFFCFC),
            size: 24,
          )
        ),
        colorScheme: ColorScheme.fromSeed(
          primary: Color(0xFF15B86C),
          seedColor: Color(0xFF15B86C),
        ),
        primaryColor: Color(0xFF15B86C),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          foregroundColor: Color(0xFFFFFCFC),
          backgroundColor: Color(0xFF15B86C),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          iconSize: 18,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            foregroundColor: Color(0xFFFFFCFC),
            backgroundColor: Color(0xFF15B86C),
            fixedSize: Size(MediaQuery.of(context).size.width, 40),
            textStyle: Theme.of(context).textTheme.displaySmall?.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Color(0xFF282828),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          hintStyle: TextStyle(color: Color(0xFF6D6D6D)),
        ),
        textTheme: TextTheme(
          displayLarge: TextStyle(
            color: Color(0xFFFFFCFC),
            fontWeight: FontWeight.w400,
            fontSize: 32,
          ),
          displayMedium: TextStyle(
            color: Color(0xFFFFFCFC),
            fontWeight: FontWeight.w400,
            fontSize: 24,
          ),
          displaySmall: TextStyle(
            color: Color(0xFFFFFCFC),
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
          titleMedium: TextStyle(
            color: Color(0xFFFFFCFC),
            fontWeight: FontWeight.w400,
            fontSize: 28,
          ),
        ),
      ),
      home: name == null ? StartScreen() : MainScreen(),
    );
  }
}
