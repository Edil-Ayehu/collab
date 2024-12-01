import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:collab/presentation/blocs/auth/auth_bloc.dart';
import 'package:collab/presentation/widgets/common/avatar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // TODO: Navigate to edit profile
            },
          ),
        ],
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return state.maybeMap(
            authenticated: (state) {
              final user = state.user;
              return ListView(
                padding: EdgeInsets.all(16.w),
                children: [
                  Center(
                    child: Avatar(
                      imageUrl: user.photoUrl,
                      size: 120.r,
                      name: user.name ?? user.email,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  _buildInfoCard(
                    theme,
                    children: [
                      _buildInfoTile(
                        theme,
                        icon: Icons.person_outline,
                        title: 'Name',
                        value: user.name ?? 'Not set',
                      ),
                      _buildInfoTile(
                        theme,
                        icon: Icons.email_outlined,
                        title: 'Email',
                        value: user.email,
                      ),
                      if (user.phone != null)
                        _buildInfoTile(
                          theme,
                          icon: Icons.phone_outlined,
                          title: 'Phone',
                          value: user.phone!,
                        ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  _buildInfoCard(
                    theme,
                    children: [
                      _buildStatTile(
                        theme,
                        icon: Icons.folder_outlined,
                        title: 'Projects',
                        value: '0',  // TODO: Add actual projects count
                      ),
                      _buildStatTile(
                        theme,
                        icon: Icons.task_outlined,
                        title: 'Tasks',
                        value: '0',  // TODO: Add actual tasks count
                      ),
                    ],
                  ),
                ],
              );
            },
            orElse: () => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoCard(ThemeData theme, {required List<Widget> children}) {
    return Card(
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildInfoTile(
    ThemeData theme, {
    required IconData icon,
    required String title,
    required String value,
  }) {
    return ListTile(
      leading: Icon(icon, color: theme.colorScheme.primary),
      title: Text(
        title,
        style: TextStyle(
          color: theme.colorScheme.onSurface.withOpacity(0.7),
          fontSize: 14.sp,
        ),
      ),
      subtitle: Text(
        value,
        style: TextStyle(
          color: theme.colorScheme.onSurface,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildStatTile(
    ThemeData theme, {
    required IconData icon,
    required String title,
    required String value,
  }) {
    return ListTile(
      leading: Icon(icon, color: theme.colorScheme.primary),
      title: Text(title),
      trailing: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Text(
          value,
          style: TextStyle(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
} 