import 'package:appwrite_starter/core/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          const SizedBox(height: kToolbarHeight),
          Text(
            "Welcome to Flutter Appwrite Starter",
            style: Theme.of(context).textTheme.headline3,
          ),
        ],
      ),
      bottomNavigationBar: ElevatedButton(
        child: Text("Get Started"),
        onPressed: () async {
          await context.read(userRepoProvider).introSeen();
        },
      ),
    );
  }
}
