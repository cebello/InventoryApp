import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../infrastructure/datasources/auth_datasource.dart';
import '../../../domain/entities/auth.dart';

final authProvider = StateNotifierProvider<AuthNotifier, Auth?>(
  (ref) => AuthNotifier(),
);

class AuthNotifier extends StateNotifier<Auth?> {
  AuthNotifier() : super(null) {
    _loadAuth();
  }

  Future<void> _loadAuth() async {
    final prefs = await SharedPreferences.getInstance();
    final authString = prefs.getString('auth');

    if (authString != null) {
      final authJson = jsonDecode(authString);
      state = Auth.fromJson(authJson);
    } else {
      state = null;
    }
  }

  Future<bool> login(String email, String password) async {
    final result = await AuthDatasource.login(email, password);
    if (result != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth', jsonEncode(result.toJson()));
      state = result;
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth');
    state = null;
  }
}
