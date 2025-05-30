import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/constants/storage_key.dart';
import 'package:tasky/features/tasks/controller/task_controller.dart';
import 'package:tasky/widgets/task_list_widget.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TaskController()..init(),
      child: Consumer<TaskController>(
        builder: (context, controller, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  'To Do Tasks',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: controller.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : TaskListWidget(
                          tasks: controller.todoTasks,
                          emptyMessage: 'No Task Found',
                          onTap: (value, index) async {
                            controller.toggleTaskStatus(
                              index!,
                              value ?? false,
                              StorageKey.tasks,
                            );
                            controller.loadTasks();
                          },
                          onDelete: (int? id) {
                            controller.deleteTask(id!);
                          },
                          onEdit: () {
                            controller.loadTasks();
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
