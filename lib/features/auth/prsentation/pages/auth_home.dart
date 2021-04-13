import 'package:appwrite_starter/core/presentation/providers/providers.dart';
import 'package:appwrite_starter/features/auth/prsentation/notifiers/user_repository.dart';
import 'package:appwrite_starter/features/auth/prsentation/pages/login.dart';
import 'package:appwrite_starter/features/general/presentation/pages/home.dart';
import 'package:appwrite_starter/features/general/presentation/pages/intro.dart';
import 'package:appwrite_starter/features/general/presentation/pages/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthHomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final user = watch(userRepoProvider);
    switch (user.status) {
      case Status.Unauthenticated:
        return LoginPage();
      case Status.Authenticated:
        return (user.isLoading) ? SplashPage() : (user.user.prefs.introSeen ?? false) ? HomePage() : IntroPage();
      case Status.Uninitialized:
      case Status.Authenticating:
      default:
        return SplashPage();
    }
  }
}
