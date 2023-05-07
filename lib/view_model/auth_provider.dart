import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/user_api.dart';
import '../model/user_model.dart';

class AuthProvider extends ChangeNotifier {
  User _user = User();

  User get user => _user;

  set user(User user) {
    _user = user;
    notifyListeners();
  }

  //login
  Future<void> login(String name, String password) async {
    try {
      final user = await ApiUser().loginUser(name, password);
      _user = user;
      var prefs = await SharedPreferences.getInstance();
      await prefs.setString('name', user.name.toString());
      await prefs.setString('password', user.password.toString());

      notifyListeners();
    } catch (e) {
      print('error: $e');
    }
  }
}
