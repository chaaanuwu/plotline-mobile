import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:plotline_mobile/features/auth/data/models/auth_model.dart';

abstract class AuthLocalDataSource {
  Future<void> saveAuth(AuthModel auth);

  Future<AuthModel?> getAuth();

  Future<void> removeAuth();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  static const String _authKey = 'auth_data';

  @override
Future<void> saveAuth(AuthModel auth) async {
  final prefs = await SharedPreferences.getInstance();

  print('AUTH: Saving token: ${auth.token}');
  print('AUTH: Saving userId: ${auth.userId}');

  await prefs.setString(
    _authKey,
    jsonEncode(auth.toJson()),
  );

  print('AUTH: Saved data: ${prefs.getString(_authKey)}');
}

  @override
  Future<AuthModel?> getAuth() async {
    final prefs = await SharedPreferences.getInstance();
    final authJson = prefs.getString(_authKey);

    if (authJson == null) {
      return null;
    }

    try {
      final decoded = jsonDecode(authJson);

      if (decoded is! Map) {
        return null;
      }

      return AuthModel.fromJson(Map<String, dynamic>.from(decoded));
    } on FormatException {
      await removeAuth();
      return null;
    } catch (e) {
      await removeAuth();
      return null;
    }
  }

  @override
  Future<void> removeAuth() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_authKey);
  }
}
