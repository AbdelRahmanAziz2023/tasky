import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widgets/custom_svg_picture.dart';
import '../../tasks/controller/task_controller.dart';
import '../../tasks/screens/add_task_screen.dart';
import '../controller/home_controller.dart';
import '../widgets/achieved_tasks_widget.dart';
import '../widgets/high_priority_tasks_widget.dart';
import '../widgets/sliver_task_list_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TaskController>(
          create: (_) => TaskController(),
        ),
        ChangeNotifierProxyProvider<TaskController, HomeController>(
          create: (context) => HomeController(context.read<TaskController>())..init(),
          update: (context, taskController, homeController) =>
          homeController!..taskController = taskController,
        ),
      ],
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Selector<HomeController, String?>(
                          selector: (context, HomeController controller) =>
                              controller.userImagePath,
                          builder:
                              (
                                BuildContext context,
                                String? userImagePath,
                                Widget? child,
                              ) {
                                return CircleAvatar(
                                  backgroundImage: userImagePath == null
                                      ? AssetImage('assets/images/person.png')
                                      : FileImage(File(userImagePath)),
                                );
                              },
                        ),
                        SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Selector<HomeController, String?>(
                              selector: (context, HomeController controller) =>
                                  controller.username,
                              builder:
                                  (
                                    BuildContext context,
                                    String? username,
                                    Widget? child,
                                  ) {
                                    return Text(
                                      "Good Evening, $username",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleMedium,
                                    );
                                  },
                            ),
                            Text(
                              "One task at a time. One step closer.",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Yuhuu ,Your work Is',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    Row(
                      children: [
                        Text(
                          'almost done ! ',
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        CustomSvgPicture.withoutColor(
                          path: 'assets/images/waving_hand.svg',
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    AchievedTasksWidget(),
                    SizedBox(height: 8),
                    HighPriorityTasksWidget(),
                    Padding(
                      padding: const EdgeInsets.only(top: 24, bottom: 16),
                      child: Text(
                        'My Tasks',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  ],
                ),
              ),
              SliverTaskListWidget(),
            ],
          ),
        ),
        floatingActionButton: SizedBox(
          height: 44,
          child: Builder(
            builder: (BuildContext context) {
              return FloatingActionButton.extended(
                onPressed: () async {
                  final bool? result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return AddTaskScreen();
                      },
                    ),
                  );

                  if (result != null && result) {
                    context.read<TaskController>().loadTasks();
                  }
                },
                label: Text('Add New Task'),
                icon: Icon(Icons.add),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
