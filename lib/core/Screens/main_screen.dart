import 'package:flutter/material.dart';
import 'package:tasky/core/Screens/complete_screen.dart';
import 'package:tasky/core/Screens/home_screen.dart';
import 'package:tasky/core/Screens/profile_screen.dart';
import 'package:tasky/core/Screens/todo_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  List<Widget> screens = [
    HomeScreen(),
    TodoScreen(),
    CompleteScreen(),
    ProfileScreen(),
  ];

  int _currentIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex:_currentIndex ,
        onTap: (index){
          setState(() {
            _currentIndex=index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined),label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt_rounded),label: 'To Do'),
          BottomNavigationBarItem(icon: Icon(Icons.checklist_rtl_rounded),label: 'Complete'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined),label: 'Profile'),
        ],
      ),
      body: screens[_currentIndex],
    );
  }
}
