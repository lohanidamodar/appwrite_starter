import 'package:appwrite/appwrite.dart';
import 'package:appwrite_starter/core/res/app_constants.dart';

class ApiService {
  static ApiService _instance;
  final Client client = Client();
  Account account;
  Database db;
  Avatars avatars;

  ApiService._internal() {
    client
        .setEndpoint(AppConstants.endpoint)
        .setProject(AppConstants.project)
        .addHeader('Origin', 'http://localhost');
    account = Account(client);
    db = Database(client);
    avatars = Avatars(client);
  }

  static ApiService get instance {
    if (_instance == null) {
      _instance = ApiService._internal();
    }
    return _instance;
  }

  Future signup({String name, String email, String password}) async {
    return account.create(name: name, email: email, password: password);
  }

  Future login({String email, String password}) async {
    return account.createSession(email: email, password: password);
  }

  Future logOut() {
    return account.deleteSessions();
  }

  Future getUser() {
    return account.get();
  }

  Future updatePrefs(Map<String, dynamic> data) {
    return account.updatePrefs(prefs: data);
  }

  Future getInitialsAvatar(String name) {
    return avatars.getInitials(name: name, width: 200);
  }
}
