import 'package:appwrite_starter/features/auth/prsentation/notifiers/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userRepoProvider =
    ChangeNotifierProvider<UserRepository>((ref) => UserRepository());
