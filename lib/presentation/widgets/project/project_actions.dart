import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:collab/domain/entities/project.dart';

class ProjectActions extends StatelessWidget {
  final Project project;
  final VoidCallback onEdit;
  final VoidCallback onArchive;
  final VoidCallback onDelete;
  final VoidCallback onShare;
  final VoidCallback onExport;

  const ProjectActions({
    super.key,
    required this.project,
    required this.onEdit,
    required this.onArchive,
    required this.onDelete,
    required this.onShare,
    required this.onExport,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Project Actions',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: [
                ActionChip(
                  avatar: const Icon(Icons.edit),
                  label: const Text('Edit'),
                  onPressed: onEdit,
                ),
                ActionChip(
                  avatar: Icon(
                    project.isArchived
                        ? Icons.unarchive
                        : Icons.archive,
                  ),
                  label: Text(
                    project.isArchived ? 'Unarchive' : 'Archive',
                  ),
                  onPressed: onArchive,
                ),
                ActionChip(
                  avatar: const Icon(Icons.share),
                  label: const Text('Share'),
                  onPressed: onShare,
                ),
                ActionChip(
                  avatar: const Icon(Icons.file_download),
                  label: const Text('Export'),
                  onPressed: onExport,
                ),
                ActionChip(
                  avatar: const Icon(Icons.delete),
                  label: const Text('Delete'),
                  backgroundColor: theme.colorScheme.errorContainer,
                  labelStyle: TextStyle(
                    color: theme.colorScheme.onErrorContainer,
                  ),
                  onPressed: onDelete,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 