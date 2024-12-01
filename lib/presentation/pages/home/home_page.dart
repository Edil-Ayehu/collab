import 'package:collab/core/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collab/presentation/cubits/navigation/navigation_cubit.dart';
import 'package:collab/presentation/pages/home/views/home_view.dart';
import 'package:collab/presentation/pages/home/views/tasks_view.dart';
import 'package:collab/presentation/pages/home/views/projects_view.dart';
import 'package:collab/presentation/pages/home/views/settings_view.dart';
import 'package:collab/config/routes/app_routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<NavigationCubit>(),
      child: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: state.when(
                home: () => const Text('Home'),
                tasks: () => const Text('Tasks'),
                projects: () => const Text('Projects'),
                settings: () => const Text('Settings'),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.notifications_outlined),
                  onPressed: () {
                    // TODO: Implement notifications
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.person_outline),
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.profile);
                  },
                ),
              ],
            ),
            body: SafeArea(
              child: state.when(
                home: () => const HomeView(),
                tasks: () => const TasksView(),
                projects: () => const ProjectsView(),
                settings: () => const SettingsView(),
              ),
            ),
            bottomNavigationBar: NavigationBar(
              selectedIndex: state.when(
                home: () => 0,
                tasks: () => 1,
                projects: () => 2,
                settings: () => 3,
              ),
              onDestinationSelected: (index) {
                context.read<NavigationCubit>().setPage(index);
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Icons.task_outlined),
                  selectedIcon: Icon(Icons.task),
                  label: 'Tasks',
                ),
                NavigationDestination(
                  icon: Icon(Icons.folder_outlined),
                  selectedIcon: Icon(Icons.folder),
                  label: 'Projects',
                ),
                NavigationDestination(
                  icon: Icon(Icons.settings_outlined),
                  selectedIcon: Icon(Icons.settings),
                  label: 'Settings',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
} 