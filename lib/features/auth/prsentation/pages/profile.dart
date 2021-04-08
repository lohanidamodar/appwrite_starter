import 'package:appwrite_starter/core/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          ElevatedButton(
              onPressed: () async {
                await context.read(userRepoProvider).logOut();
                Navigator.pop(context);
              },
              child: Text("Logout"))
        ],
      ),
    );
  }
}
