import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite_starter/core/data/service/api_service.dart';
import 'package:appwrite_starter/features/auth/data/models/user.dart';
import 'package:appwrite_starter/features/auth/data/models/user_prefs.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

enum Status {
  Uninitialized,
  Authenticated,
  Authenticating,
  Unauthenticated,
}

class UserRepository extends ChangeNotifier {
  Status _status = Status.Uninitialized;
  User _user;
  String _error;
  bool _loading;

  UserRepository() {
    _error = '';
    _loading = true;
    _getUser();
  }

  String get error => _error;
  bool get isLoading => _loading;
  User get user => _user;
  Status get status => _status;

  Future _getUser() async {
    try {
      final res = await ApiService.instance.getUser();
      _user = User.fromMap(res.data);
      _saveUserPrefs();
      _status = Status.Authenticated;
    } on AppwriteException catch (e) {
      _status = Status.Unauthenticated;
      _error = e.message;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future logOut() async {
    try {
      await ApiService.instance.logOut();
      _user = null;
      _status = Status.Unauthenticated;
      notifyListeners();
    } on AppwriteException catch (e) {
      _error = e.message;
      print(_error);
      return false;
    }
  }

  Future signIn(String email, String password) async {
    _status = Status.Authenticating;
    notifyListeners();
    try {
      await ApiService.instance.login(email: email, password: password);
      _getUser();
      return true;
    } on AppwriteException catch (e) {
      _error = e.message;
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signup(String name, String email, String password) async {
    _status = Status.Authenticating;
    notifyListeners();
    try {
      await ApiService.instance
          .signup(name: name, email: email, password: password);
      _error = '';
      await signIn(email, password);
      return true;
    } on AppwriteException catch (e) {
      _error = e.message;
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  introSeen() async {
    final prefs = _user.prefs.copyWith(
      introSeen: true,
    );
    await ApiService.instance.updatePrefs(prefs.toMap());
    _user = _user.copyWith(prefs: prefs);
    notifyListeners();
  }

  _saveUserPrefs() async {
    if (_user == null) return;
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    int buildNumber = int.parse(packageInfo.buildNumber);

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    var deviceId = '';
    if (kIsWeb) {
      WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
      deviceId = webBrowserInfo.userAgent;
    } else {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceId = androidInfo.androidId;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceId = iosInfo.identifierForVendor;
      }
    }

    var prefs = _user.prefs ?? UserPrefs();
    prefs = prefs.copyWith(
      buildNumber: buildNumber,
      lastLoggedIn: DateTime.now(),
      introSeen: prefs.introSeen ?? false,
      deviceId: deviceId,
    );
    await ApiService.instance.updatePrefs(prefs.toMap());
    _user = _user.copyWith(prefs: prefs);
    notifyListeners();
  }
}
