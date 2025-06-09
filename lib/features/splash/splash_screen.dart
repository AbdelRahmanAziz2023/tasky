import 'dart:async';

import 'package:flutter/material.dart';

import '../home/screens/main_screen.dart';
import '../home/screens/start_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.username});

  final String? username;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay for 3 seconds then navigate
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => widget.username == null ? StartScreen() : MainScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/logo.png', width: 100),
      ),
    );
  }
}