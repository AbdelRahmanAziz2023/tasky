import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/Screens/add_task_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        width: 167,
        height: 40,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTaskScreen()));
          },

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add),
              SizedBox(width: 8),
              Text(
                'Add New Task',
                style: Theme.of(
                  context,
                ).textTheme.displaySmall?.copyWith(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(children: [
          SizedBox(height: 52),
          Row(children: [
            SvgPicture.asset('assets/images/user.svg'),
            SizedBox(width: 14,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text('Good Evening ,Usama ',style: Theme.of(context).textTheme.displaySmall,),
              Text('One task at a time.One step closer.',style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Color(0xFFC6C6C6),fontSize: 14),)
            ],)
          ],),
          SizedBox(height: 52),
          Row(
            children: [
              Text(
                'Yuhuu ,Your work Is \n almost done !  👋🏻',
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
