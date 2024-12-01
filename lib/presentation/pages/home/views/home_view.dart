import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:collab/core/di/injection.dart';
import 'package:collab/presentation/cubits/projects/projects_cubit.dart';
import 'package:collab/presentation/cubits/tasks/tasks_cubit.dart';
import 'package:collab/presentation/widgets/project/project_form.dart';
import 'package:collab/presentation/blocs/auth/auth_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    // Load projects and tasks when HomeView is initialized
    context.read<ProjectsCubit>().loadProjects();
    context.read<TasksCubit>().loadTasks();
  }

  void _showCreateProjectDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => BlocProvider.value(
        value: context.read<ProjectsCubit>(),
        child: BlocConsumer<ProjectsCubit, ProjectsState>(
          listener: (context, state) {
            state.maybeMap(
              error: (error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(error.message),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              loaded: (_) {
                Navigator.pop(dialogContext);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Project created successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              orElse: () {},
            );
          },
          builder: (context, state) {
            final isLoading = state.maybeMap(
              loading: (_) => true,
              orElse: () => false,
            );

            return Dialog(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Create Project',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    if (isLoading)
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: CircularProgressIndicator(),
                      )
                    else
                      ProjectForm(
                        onSubmit: (title, description, tags) {
                          final userId =
                              context.read<AuthBloc>().state.maybeMap(
                                    authenticated: (state) => state.user.id,
                                    orElse: () => '',
                                  );

                          if (userId.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('User not authenticated'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }

                          context.read<ProjectsCubit>().createProject(
                            title: title,
                            description: description,
                            memberIds: [userId],
                          );
                        },
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showCreateTaskDialog(BuildContext context) {
    // TODO: Implement when TaskForm widget is created
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Task creation coming soon!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        return Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome back${authState.maybeMap(
                  authenticated: (state) =>
                      state.user.name != null ? ', ${state.user.name}' : '!',
                  orElse: () => '!',
                )}',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 24.h),
              _buildQuickActions(context),
              SizedBox(height: 24.h),
              _buildRecentActivities(context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            _buildActionCard(
              icon: Icons.add_task,
              label: 'New Task',
              onTap: () => _showCreateTaskDialog(context),
            ),
            SizedBox(width: 16.w),
            _buildActionCard(
              icon: Icons.folder_open,
              label: 'New Project',
              onTap: () => _showCreateProjectDialog(context),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            children: [
              Icon(icon, size: 32.w),
              SizedBox(height: 8.h),
              Text(label),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentActivities(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Activities',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 16.h),
        BlocBuilder<ProjectsCubit, ProjectsState>(
          builder: (context, projectsState) {
            return BlocBuilder<TasksCubit, TasksState>(
              builder: (context, tasksState) {
                if (projectsState.maybeMap(
                      loading: (_) => true,
                      orElse: () => false,
                    ) ||
                    tasksState.maybeMap(
                      loading: (_) => true,
                      orElse: () => false,
                    )) {
                  return const Center(child: CircularProgressIndicator());
                }

                final activities = <Widget>[];

                // Add recent projects
                projectsState.maybeMap(
                  loaded: (state) {
                    final recentProjects = state.projects.take(2);
                    for (final project in recentProjects) {
                      activities.add(
                        Card(
                          margin: EdgeInsets.only(bottom: 8.h),
                          child: ListTile(
                            leading: const CircleAvatar(
                              child: Icon(Icons.folder),
                            ),
                            title: Text(project.title),
                            subtitle: Text(project.description),
                            trailing: Text(
                              'Created ${_formatTimeAgo(project.createdAt)}',
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  orElse: () {},
                );

                // Add recent tasks
                tasksState.maybeMap(
                  loaded: (state) {
                    final recentTasks = state.tasks.take(2);
                    for (final task in recentTasks) {
                      activities.add(
                        Card(
                          margin: EdgeInsets.only(bottom: 8.h),
                          child: ListTile(
                            leading: const CircleAvatar(
                              child: Icon(Icons.task),
                            ),
                            title: Text(task.title),
                            subtitle: Text(task.description ?? ''),
                            trailing: Text(
                              'Due ${_formatTimeAgo(task.dueDate)}',
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  orElse: () {},
                );

                if (activities.isEmpty) {
                  return Center(
                    child: Text(
                      'No recent activities',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.grey,
                      ),
                    ),
                  );
                }

                return ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: activities,
                );
              },
            );
          },
        ),
      ],
    );
  }

  String _formatTimeAgo(DateTime dateTime) {
    final difference = DateTime.now().difference(dateTime);
    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'just now';
    }
  }
}
