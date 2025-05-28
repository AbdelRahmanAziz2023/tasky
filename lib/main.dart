import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/Screens/start_screen.dart';

import 'Screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tasky',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF181818),
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF15B86C)),
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
      home: StartScreen(),
    );
  }
}
