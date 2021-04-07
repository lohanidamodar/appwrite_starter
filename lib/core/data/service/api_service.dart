import 'package:appwrite/appwrite.dart';
import 'package:appwrite_starter/core/res/app_constants.dart';

class ApiService {
  static ApiService _instance;
  final Client client = Client();
  Account account;
  Database db;

  ApiService._internal() {
    client.setEndpoint(AppConstants.endpoint).setProject(AppConstants.project);
    account = Account(client);
    db = Database(client);
  }

  static ApiService get instance {
    if (_instance == null) {
      _instance = ApiService._internal();
    }
  }

  Future signup({String name, String email, String password}) async {
    return account.create(name: name, email: email, password: password);
  }

  Future login({String email, String password}) async {
    return account.createSession(email: email, password: password);
  }
}
