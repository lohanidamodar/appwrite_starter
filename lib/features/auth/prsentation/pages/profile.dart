import 'package:appwrite_starter/core/data/service/api_service.dart';
import 'package:appwrite_starter/core/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final userRepo = watch(userRepoProvider);
    final user = userRepo.user;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          FutureBuilder(
            future: ApiService.instance.getInitialsAvatar(user.name),
            builder: (context, snapshot) {
              if (snapshot.hasData)
                return Center(
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: MemoryImage(snapshot.data.data),
                  ),
                );
              return SizedBox(
                height: 0,
              );
            },
          ),
          Text(
            user.name,
            style: Theme.of(context).textTheme.headline6,
          ),
          Text(user.email),
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
