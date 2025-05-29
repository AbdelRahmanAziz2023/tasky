import 'dart:convert';

class TaskModel {
  final int id;
  final String title;
  final String description;
  final bool isHighPriority;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.isHighPriority,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isHighPriority': isHighPriority,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      isHighPriority: map['isHighPriority'],
    );
  }

  @override
  String toString() {
    return 'TaskModel(id: $id, title: $title, description: $description, isHighPriority: $isHighPriority)';
  }

}
