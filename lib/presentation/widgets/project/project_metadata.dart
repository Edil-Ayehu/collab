import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ProjectMetadata extends StatelessWidget {
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isArchived;

  const ProjectMetadata({
    super.key,
    required this.createdAt,
    this.updatedAt,
    required this.isArchived,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM d, y');
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Project Info',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.h),
        Card(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Created'),
                    Text(dateFormat.format(createdAt)),
                  ],
                ),
                if (updatedAt != null) ...[
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Last Updated'),
                      Text(dateFormat.format(updatedAt!)),
                    ],
                  ),
                ],
                if (isArchived) ...[
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Status'),
                      Chip(
                        label: const Text('Archived'),
                        backgroundColor: theme.colorScheme.errorContainer,
                        labelStyle: TextStyle(
                          color: theme.colorScheme.onErrorContainer,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
} 