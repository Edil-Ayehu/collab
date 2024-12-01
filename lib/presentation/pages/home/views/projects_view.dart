import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:collab/core/di/injection.dart';
import 'package:collab/domain/entities/project.dart';
import 'package:collab/presentation/cubits/projects/projects_cubit.dart';
import 'package:collab/presentation/widgets/project/project_card.dart';
import 'package:collab/presentation/widgets/project/project_form.dart';
import 'package:collab/presentation/pages/project/project_details_page.dart';

class ProjectsView extends StatelessWidget {
  const ProjectsView({super.key});

  void _showCreateProjectDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
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
              ProjectForm(
                onSubmit: (title, description, tags) {
                  context.read<ProjectsCubit>().createProject(
                        title: title,
                        description: description,
                        memberIds: [/* TODO: Add current user ID */],
                      );
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, Project project) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Project'),
        content: Text('Are you sure you want to delete "${project.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              context.read<ProjectsCubit>().deleteProject(project.id);
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProjectsCubit>()..loadProjects(),
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Search projects...',
                        prefixIcon: Icon(Icons.search),
                      ),
                      onChanged: (value) => context
                          .read<ProjectsCubit>()
                          .setSearchQuery(value.isEmpty ? null : value),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  PopupMenuButton<ProjectFilter>(
                    icon: const Icon(Icons.filter_list),
                    onSelected: (filter) =>
                        context.read<ProjectsCubit>().setFilter(filter),
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: ProjectFilter.all,
                        child: Text('All Projects'),
                      ),
                      const PopupMenuItem(
                        value: ProjectFilter.active,
                        child: Text('Active Projects'),
                      ),
                      const PopupMenuItem(
                        value: ProjectFilter.archived,
                        child: Text('Archived Projects'),
                      ),
                    ],
                  ),
                  PopupMenuButton<ProjectSort>(
                    icon: const Icon(Icons.sort),
                    onSelected: (sort) =>
                        context.read<ProjectsCubit>().setSort(sort),
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: ProjectSort.newest,
                        child: Text('Newest First'),
                      ),
                      const PopupMenuItem(
                        value: ProjectSort.oldest,
                        child: Text('Oldest First'),
                      ),
                      const PopupMenuItem(
                        value: ProjectSort.title,
                        child: Text('By Title'),
                      ),
                      const PopupMenuItem(
                        value: ProjectSort.progress,
                        child: Text('By Progress'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<ProjectsCubit, ProjectsState>(
                builder: (context, state) {
                  return state.map(
                    initial: (_) => const SizedBox(),
                    loading: (_) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    loaded: (state) => ListView.builder(
                      padding: EdgeInsets.all(16.w),
                      itemCount: state.projects.length,
                      itemBuilder: (context, index) {
                        final project = state.projects[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 16.h),
                          child: ProjectCard(
                            project: project,
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProjectDetailsPage(project: project),
                              ),
                            ),
                            onEdit: () {
                              // TODO: Show edit dialog
                            },
                            onDelete: () => _showDeleteConfirmation(
                              context,
                              project,
                            ),
                            onArchive: () => context
                                .read<ProjectsCubit>()
                                .archiveProject(project.id),
                          ),
                        );
                      },
                    ),
                    error: (state) => Center(
                      child: Text(state.message),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showCreateProjectDialog(context),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
} 