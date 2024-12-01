import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:collab/domain/entities/task.dart';

part 'tasks_state.dart';
part 'tasks_cubit.freezed.dart';

@injectable
class TasksCubit extends Cubit<TasksState> {
  TasksCubit() : super(const TasksState.initial());

  void loadTasks() {
    emit(const TasksState.loading());
    // TODO: Implement task loading from repository
    emit(TasksState.loaded([]));
  }

  void updateTaskStatus(String taskId, TaskStatus newStatus) {
    // TODO: Implement task status update
  }

  void deleteTask(String taskId) {
    // TODO: Implement task deletion
  }
} 