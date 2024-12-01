import 'package:collab/presentation/cubits/users/users_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';
import 'package:collab/core/di/injection.dart';
import 'package:collab/domain/entities/project.dart';
import 'package:collab/presentation/cubits/projects/projects_cubit.dart';
import 'package:collab/presentation/widgets/project/project_form.dart';
import 'package:collab/presentation/widgets/project/project_progress.dart';
import 'package:collab/presentation/widgets/project/members_list.dart';
import 'package:collab/presentation/widgets/project/progress_update_dialog.dart';
import 'package:collab/presentation/widgets/project/add_member_dialog.dart';
import 'package:collab/presentation/cubits/users/users_cubit.dart';
import 'package:collab/presentation/widgets/project/project_actions.dart';

class ProjectDetailsPage extends StatelessWidget {
  final Project project;

  const ProjectDetailsPage({
    super.key,
    required this.project,
  });

  void _showEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Edit Project',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.h),
              ProjectForm(
                project: project,
                onSubmit: (title, description, tags) {
                  final updatedProject = Project(
                    id: project.id,
                    title: title,
                    description: description,
                    progress: project.progress,
                    memberIds: project.memberIds,
                    createdAt: project.createdAt,
                    updatedAt: DateTime.now(),
                    isArchived: project.isArchived,
                    tags: tags,
                    metadata: project.metadata,
                  );
                  context.read<ProjectsCubit>().updateProject(updatedProject);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showProgressUpdateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ProgressUpdateDialog(
        initialProgress: project.progress,
        onUpdate: (progress) {
          final updatedProject = Project(
            id: project.id,
            title: project.title,
            description: project.description,
            progress: progress,
            memberIds: project.memberIds,
            createdAt: project.createdAt,
            updatedAt: DateTime.now(),
            isArchived: project.isArchived,
            tags: project.tags,
            metadata: project.metadata,
          );
          context.read<ProjectsCubit>().updateProject(updatedProject);
        },
      ),
    );
  }

  void _showAddMemberDialog(BuildContext context) {
    // TODO: Get available users from UsersCubit
    showDialog(
      context: context,
      builder: (context) => AddMemberDialog(
        availableUsers: const [], // TODO: Pass available users
        currentMemberIds: project.memberIds,
        onAdd: (userId) {
          context.read<ProjectsCubit>().addMember(
                projectId: project.id,
                userId: userId,
              );
        },
      ),
    );
  }

  void _shareProject(BuildContext context) {
    Share.share(
      'Check out this project: ${project.title}\n\n${project.description}',
      subject: project.title,
    );
  }

  void _exportProject() {
    // TODO: Implement project export functionality
  }

  void _showDeleteConfirmation(BuildContext context) {
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
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Go back to projects list
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<UsersCubit>()..loadUsers(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(project.title),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (project.coverImageUrl != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.network(
                    project.coverImageUrl!,
                    width: double.infinity,
                    height: 200.h,
                    fit: BoxFit.cover,
                  ),
                ),
              SizedBox(height: 16.h),
              Text(
                project.description,
                style: TextStyle(fontSize: 16.sp),
              ),
              SizedBox(height: 24.h),
              ProjectProgress(
                progress: project.progress,
                onTap: () => _showProgressUpdateDialog(context),
              ),
              SizedBox(height: 24.h),
              ProjectActions(
                project: project,
                onEdit: () => _showEditDialog(context),
                onArchive: () =>
                    context.read<ProjectsCubit>().archiveProject(project.id),
                onDelete: () => _showDeleteConfirmation(context),
                onShare: () => _shareProject(context),
                onExport: _exportProject,
              ),
              SizedBox(height: 24.h),
              BlocBuilder<UsersCubit, UsersState>(
                builder: (context, state) {
                  return state.maybeMap(
                    loaded: (state) => MembersList(
                      members: state.users
                          .where((user) => project.memberIds.contains(user.id))
                          .toList(),
                      currentUser: null, // TODO: Get current user
                      onRemoveMember: (userId) {
                        context.read<ProjectsCubit>().removeMember(
                              projectId: project.id,
                              userId: userId,
                            );
                      },
                    ),
                    error: (state) => Center(
                      child: Text(state.message),
                    ),
                    orElse: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showAddMemberDialog(context),
          child: const Icon(Icons.person_add),
        ),
      ),
    );
  }
}
