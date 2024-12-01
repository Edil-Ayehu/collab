import 'package:collab/config/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:collab/config/routes/app_routes.dart';
import 'package:collab/config/themes/app_theme.dart';
import 'package:collab/presentation/blocs/auth/auth_bloc.dart';
import 'package:collab/presentation/cubits/projects/projects_cubit.dart';
import 'package:collab/presentation/cubits/tasks/tasks_cubit.dart';
import 'package:collab/core/di/injection.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => getIt<AuthBloc>(),
            ),
            BlocProvider(
              create: (context) => getIt<ProjectsCubit>(),
            ),
            BlocProvider(
              create: (context) => getIt<TasksCubit>(),
            ),
          ],
          child: MaterialApp(
            title: 'Collab',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            onGenerateRoute: AppRouter.onGenerateRoute,
            initialRoute: AppRoutes.splash,
          ),
        );
      },
    );
  }
}
