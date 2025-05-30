import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/features/tasks/controller/task_controller.dart';

import '../../../core/constants/storage_key.dart';
import '../../../widgets/task_list_widget.dart';


class CompleteScreen extends StatelessWidget {
  const CompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => TaskController()..init(),
      child: Consumer<TaskController>(
        builder: (context, taskController, _) {
          final completeTasks = taskController.completeTasks;
          final isLoading = taskController.isLoading;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(18.0),
                child: Text('Completed Tasks'),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : TaskListWidget(
                          tasks: completeTasks,
                          emptyMessage: 'No Task Found',
                          onTap: (value, index) async {
                            taskController.toggleTaskStatus(
                              index!,
                              value ?? false,
                              StorageKey.tasks,
                            );
                          },
                          onDelete: (int? id) {
                            taskController.deleteTask(id!);
                          },
                          onEdit: () {
                            taskController.init(); // reload
                          },
                        ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
