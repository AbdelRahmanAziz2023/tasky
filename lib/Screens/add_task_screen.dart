import 'package:flutter/material.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF181818),
        title: Text(
          'New Task',
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text('Task Name', style: Theme.of(context).textTheme.displaySmall),
            SizedBox(height: 8),
            SizedBox(
              height: 56,
              child: TextField(
                style: Theme.of(context).textTheme.displaySmall,
                cursorColor: Colors.white,

                decoration: InputDecoration(
                  fillColor: Color(0xFF282828),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  hintText: 'Finish UI design for login screen',
                  hintStyle: Theme.of(
                    context,
                  ).textTheme.displaySmall?.copyWith(color: Color(0xFF6D6D6D)),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Text(
              'Task Description',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            SizedBox(height: 8),
            SizedBox(
              height: 160,
              child: TextField(
                style: Theme.of(context).textTheme.displaySmall,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  fillColor: Color(0xFF282828),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  hintText:
                      'Finish onboarding UI and hand off to devs by Thursday.',
                  hintStyle: Theme.of(
                    context,
                  ).textTheme.displaySmall?.copyWith(color: Color(0xFF6D6D6D) ),

                ),
                maxLines: null,
                textAlignVertical: TextAlignVertical.top,
                minLines: 10,
              ),
            ),
            SizedBox(height: 100,),
            ElevatedButton(onPressed: (){}, child: Row(
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
            ),)
          ],
        ),
      ),
    );
  }
}
