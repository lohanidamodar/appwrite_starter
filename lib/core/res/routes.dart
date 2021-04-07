import 'package:appwrite_starter/features/auth/pages/login.dart';
import 'package:appwrite_starter/features/auth/pages/signup.dart';
import 'package:appwrite_starter/features/general/presentation/pages/home.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const home = "/";
  static const login = "login";
  static const signup = "signup";
  static const loggedInHome = "home";

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (_) {
      switch (settings.name) {
        case home:
        case login:
          return LoginPage();
        case signup:
          return SignupPage();
        case loggedInHome:
          return HomePage();
      }
    });
  }
}
