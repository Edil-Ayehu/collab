import 'package:collab/core/di/injection.dart';
import 'package:collab/domain/entities/task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:collab/presentation/cubits/tasks/tasks_cubit.dart';
import 'package:collab/presentation/widgets/common/confirmation_dialog.dart';

class TasksView extends StatelessWidget {
  const TasksView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TasksCubit>()..loadTasks(),
      child: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            TabBar(
              tabs: [
                Tab(text: 'To Do'),
                Tab(text: 'In Progress'),
                Tab(text: 'Completed'),
              ],
            ),
            Expanded(
              child: BlocBuilder<TasksCubit, TasksState>(
                builder: (context, state) {
                  return state.when(
                    initial: () => const SizedBox(),
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    loaded: (tasks) => TabBarView(
                      children: [
                        _buildTaskList(context, tasks, TaskStatus.todo),
                        _buildTaskList(context, tasks, TaskStatus.inProgress),
                        _buildTaskList(context, tasks, TaskStatus.completed),
                      ],
                    ),
                    error: (message) => Center(
                      child: Text(message),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskList(
    BuildContext context,
    List<Task> tasks,
    TaskStatus status,
  ) {
    final filteredTasks = tasks.where((task) => task.status == status).toList();

    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: filteredTasks.length,
      itemBuilder: (context, index) {
        final task = filteredTasks[index];
        return Card(
          margin: EdgeInsets.only(bottom: 8.h),
          child: ListTile(
            leading: Checkbox(
              value: task.status == TaskStatus.completed,
              onChanged: (value) {
                context.read<TasksCubit>().updateTaskStatus(
                      task.id,
                      value! ? TaskStatus.completed : TaskStatus.todo,
                    );
              },
            ),
            title: Text(task.title),
            subtitle: Text(task.dueDate.toString()),
            trailing: PopupMenuButton(
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'edit',
                  child: Text('Edit'),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Text('Delete'),
                ),
              ],
              onSelected: (value) {
                if (value == 'delete') {
                  showDialog(
                    context: context,
                    builder: (context) => ConfirmationDialog(
                      title: 'Delete Task',
                      message: 'Are you sure you want to delete this task?',
                      confirmLabel: 'Delete',
                      onConfirm: () {
                        context.read<TasksCubit>().deleteTask(task.id);
                      },
                    ),
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }
} 