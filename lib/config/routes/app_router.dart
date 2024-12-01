import 'package:flutter/material.dart';
import 'package:collab/config/routes/app_routes.dart';
import 'package:collab/core/utils/page_transitions.dart';
import 'package:collab/presentation/pages/auth/login_page.dart';
import 'package:collab/presentation/pages/auth/sign_up_page.dart';
import 'package:collab/presentation/pages/home/home_page.dart';
import 'package:collab/presentation/pages/splash/splash_page.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return FadePageRoute(child: const SplashPage());
      case AppRoutes.login:
        return SlidePageRoute(child: const LoginPage());
      case AppRoutes.signUp:
        return SlidePageRoute(child: const SignUpPage());
      case AppRoutes.home:
        return FadePageRoute(child: const HomePage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Route ${settings.name} not found!'),
            ),
          ),
        );
    }
  }
} 