import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/auth_model.dart';

class AuthLocalDataSource {
  static const String _authKey = 'auth_data';

  Future<void> saveAuth(AuthModel auth) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_authKey, jsonEncode(auth.toJson()));
  }

  Future<AuthModel?> getAuth() async {
    final prefs = await SharedPreferences.getInstance();

    final authJson = prefs.getString(_authKey);

    if (authJson == null) {
      return null;
    }

    return AuthModel.fromJson(jsonDecode(authJson) as Map<String, dynamic>);
  }

  Future<void> removeAuth() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_authKey);
  }
}
