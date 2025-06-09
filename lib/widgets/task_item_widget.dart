import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/widgets/custom_text_form_field.dart';

import '../core/constants/storage_key.dart';
import '../core/enums/task_item_actions_enum.dart';
import '../data/models/task_model.dart';
import '../data/services/preference_manager.dart';
import 'custom_check_box.dart';

class TaskItemWidget extends StatelessWidget {
  TaskItemWidget({
    super.key,
    required this.model,
    required this.onChanged,
    required this.onDelete,
    required this.onEdit,
  });

  final TaskModel model;
  final Function(bool?) onChanged;
  final Function(int) onDelete;
  final Function onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: ThemeController.isDark()
              ? Colors.transparent
              : const Color(0xFFD1DAD6),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 8),
          CustomCheckBox(
            value: model.isDone,
            onChanged: (bool? value) => onChanged(value),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.title,
                  style: model.isDone
                      ? Theme.of(context).textTheme.titleLarge
                      : Theme.of(context).textTheme.titleMedium,
                  maxLines: 1,
                ),
                if (model.description.isNotEmpty)
                  Text(
                    model.description,
                    style: const TextStyle(
                      color: Color(0xFFC6C6C6),
                      fontSize: 14,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 1,
                  ),
              ],
            ),
          ),
          PopupMenuButton<TaskItemActionsEnum>(
            icon: Icon(
              Icons.more_vert,
              color: ThemeController.isDark()
                  ? (model.isDone ? const Color(0xFFA0A0A0) : const Color(0xFFC6C6C6))
                  : (model.isDone ? const Color(0xFF6A6A6A) : const Color(0xFF3A4640)),
            ),
            onSelected: (value) async {
              switch (value) {
                case TaskItemActionsEnum.markAsDone:
                  onChanged(!model.isDone);
                  break;
                case TaskItemActionsEnum.delete:
                  await _showAlertDialog(context);
                  break;
                case TaskItemActionsEnum.edit:
                  final result = await _showButtonSheet(context, model);
                  if (result == true) onEdit();
                  break;
              }
            },
            itemBuilder: (context) => TaskItemActionsEnum.values.map((e) {
              return PopupMenuItem<TaskItemActionsEnum>(
                value: e,
                child: Text(e.name),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Future<String?> _showAlertDialog(context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Task"),
          content: const Text('Are you sure you want to delete this task?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                onDelete(model.id);
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Future<bool?> _showButtonSheet(BuildContext context, TaskModel model) {
    final taskNameController = TextEditingController(text: model.title);
    final taskDescriptionController = TextEditingController(text: model.description);
    final key = GlobalKey<FormState>();
    bool isHighPriority = model.isHighPriority;

    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                ),
                child: Form(
                  key: key,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomTextFormField(
                        controller: taskNameController,
                        name: "Task Name",
                        hintText: 'Finish UI design for login screen',
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please Enter Task Name";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      CustomTextFormField(
                        name: "Task Description",
                        controller: taskDescriptionController,
                        maxLines: 5,
                        hintText:
                        'Finish onboarding UI and hand off to devs by Thursday.',
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'High Priority',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Switch(
                            value: isHighPriority,
                            onChanged: (value) {
                              setState(() {
                                isHighPriority = value;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(MediaQuery.of(context).size.width, 48),
                        ),
                        onPressed: () async {
                          if (key.currentState?.validate() ?? false) {
                            final taskJson = PreferenceManager().getString(StorageKey.tasks);
                            List<dynamic> listTasks = [];

                            if (taskJson != null) {
                              listTasks = jsonDecode(taskJson);
                            }

                            final item = listTasks.firstWhere((e) => e['id'] == model.id);
                            final index = listTasks.indexOf(item);

                            TaskModel updated = TaskModel(
                              id: model.id,
                              title: taskNameController.text.trim(),
                              description: taskDescriptionController.text.trim(),
                              isHighPriority: isHighPriority,
                              isDone: model.isDone,
                            );

                            listTasks[index] = updated.toMap();
                            await PreferenceManager().setString(
                              StorageKey.tasks,
                              jsonEncode(listTasks),
                            );

                            Navigator.of(context).pop(true);
                          }
                        },
                        icon: const Icon(Icons.edit),
                        label: const Text('Edit Task'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
