import 'package:equatable/equatable.dart';

enum TaskStatus { todo, inProgress, completed }

class Task extends Equatable {
  final String id;
  final String title;
  final String description;
  final DateTime dueDate;
  final TaskStatus status;
  final String assigneeId;
  final String projectId;

  const Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.status,
    required this.assigneeId,
    required this.projectId,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        dueDate,
        status,
        assigneeId,
        projectId,
      ];
} 