import 'package:flutter/material.dart';
import '../helpers/db_helper.dart';
import '../models/user.dart';

class Auth with ChangeNotifier {
  User? _user;

  User? get user {
    return _user;
  }

  Future<void> login(String email, String password) async {
    final userData = await DBHelper.getUserByEmail(email);
    if (userData.isNotEmpty && userData.first['password'] == password) {
      _user =
          User(id: userData.first['id'], email: email, token: 'dummy_token');
      notifyListeners();
    } else {
      throw Exception('Invalid email or password');
    }
  }

  Future<void> signup(String email, String password) async {
    final newUser =
        User(id: DateTime.now().toString(), email: email, token: '');
    await DBHelper.insert('users', {
      'id': newUser.id,
      'email': email,
      'password': password,
    });
  }
}
