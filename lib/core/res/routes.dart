import 'package:appwrite_starter/features/auth/prsentation/pages/auth_home.dart';
import 'package:appwrite_starter/features/auth/prsentation/pages/login.dart';
import 'package:appwrite_starter/features/auth/prsentation/pages/profile.dart';
import 'package:appwrite_starter/features/auth/prsentation/pages/signup.dart';
import 'package:appwrite_starter/features/general/presentation/pages/home.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const home = "/";
  static const login = "login";
  static const signup = "signup";
  static const loggedInHome = "home";
  static const profile = "profile";

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (_) {
      switch (settings.name) {
        case profile:
          return ProfilePage();
        case login:
          return LoginPage();
        case signup:
          return SignupPage();
        case loggedInHome:
          return HomePage();
        case home:
        default:
          return AuthHomePage();
      }
    });
  }
}
