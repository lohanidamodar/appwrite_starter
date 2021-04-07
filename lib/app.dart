import 'package:appwrite_starter/core/res/routes.dart';
import 'package:appwrite_starter/features/auth/pages/login.dart';
import 'package:appwrite_starter/features/auth/pages/signup.dart';
import 'package:appwrite_starter/features/general/presentation/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Appwrite Starter',
      onGenerateTitle: (context) => AppLocalizations.of(context).appName,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: LoginPage(),
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
