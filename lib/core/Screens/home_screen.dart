import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/core/components/task_item.dart';
import 'package:tasky/core/models/task_model.dart';

import 'add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<TaskModel> tasks = [];
  String? username='';

  void getUserName()async{
    final SharedPreferences pref = await SharedPreferences.getInstance();

    username=pref.getString('username');

  }

  void getTasks() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    final String? list = pref.getString('tasks');

    List<dynamic>decodedList = [];
    if (list != null) {
      decodedList = jsonDecode(list);
    }

    tasks = decodedList.map((e) => TaskModel.fromMap(e)).toList();
    print(tasks);
  }

  @override
  void initState() {
    super.initState();
    getTasks();
    getUserName();
  }

  @override
  Widget build(BuildContext context) {
    // SharedPreferences pref=await SharedPreferences.getInstance();
    return Scaffold(
      floatingActionButton: SizedBox(
        width: 167,
        height: 40,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddTaskScreen()),
            );
          },

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add),
              SizedBox(width: 8),
              Text(
                'Add New Task',
                style: Theme
                    .of(
                  context,
                )
                    .textTheme
                    .displaySmall
                    ?.copyWith(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 52),
            Row(
              children: [
                Image.asset('assets/images/user.png',width: 42,height: 42,),
                // SvgPicture.asset('assets/images/user.png'),
                SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Good Evening ,$username ',
                      style: Theme
                          .of(context)
                          .textTheme
                          .displaySmall,
                    ),
                    Text(
                      'One task at a time.One step closer.',
                      style: Theme
                          .of(context)
                          .textTheme
                          .displaySmall
                          ?.copyWith(
                        color: Color(0xFFC6C6C6),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 52),
            Row(
              children: [
                Text(
                  'Yuhuu ,Your work Is \n almost done !  👋🏻',
                  style: Theme
                      .of(context)
                      .textTheme
                      .displayLarge,
                ),
              ],
            ),
            SizedBox(height: 52),
            Text('My Tasks',style: Theme.of(context).textTheme.displayMedium,),
            SizedBox(height: 16),
            SizedBox(height: 300,
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (BuildContext context, int index) {
              return TaskItem(checked: true, task: tasks[index]);

                },),
            )
          ],
        ),
      ),
    );
  }
}

