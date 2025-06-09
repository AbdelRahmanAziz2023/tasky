import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky/features/home/screens/home_screen.dart';
import 'package:tasky/features/profile/screens/profile_screen.dart';
import 'package:tasky/features/tasks/screens/todo_screen.dart';

import '../../tasks/screens/complete_screen.dart';

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

  SvgPicture _buildSvgPicture(String path, int index) => SvgPicture.asset(
    path,
    colorFilter: ColorFilter.mode(
      _currentIndex == index ? Color(0xFF15B86C) : Color(0xFFC6C6C6),
      BlendMode.srcIn,
    ),
  );
  
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
          BottomNavigationBarItem(
            icon: _buildSvgPicture('assets/images/home.svg', 0),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _buildSvgPicture('assets/images/todo.svg', 1),
            label: 'To Do',
          ),
          BottomNavigationBarItem(
            icon: _buildSvgPicture('assets/images/todo_complete.svg', 2),
            label: 'Completed',
          ),
          BottomNavigationBarItem(
            icon: _buildSvgPicture('assets/images/profile.svg', 3),
            label: 'Profile',
          ),
        ],
      ),
      body: SafeArea(child: screens[_currentIndex]),
    );
  }
}
