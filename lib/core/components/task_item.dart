import 'package:flutter/material.dart';
import 'package:tasky/core/models/task_model.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({
    super.key,
    required this.checked,
    required this.task,
  });

  final bool checked;
  final TaskModel task;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFF282828),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        leading: Checkbox(
          value: widget.checked,
          onChanged: (value) {
            // You can handle checkbox state here
          },
        ),
        title: Text(
          widget.task.title,
          style: Theme.of(context).textTheme.displaySmall,

        ),
        subtitle: Text(
          !widget.checked?widget.task.description:'',
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
            fontSize: 14,
            color: const Color(0xFFC6C6C6),
            overflow: TextOverflow.clip,
          ),
        ),
        trailing: const Icon(Icons.dangerous),
      ),
    );
  }
}
