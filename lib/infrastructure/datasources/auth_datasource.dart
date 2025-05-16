import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../domain/entities/auth.dart';

class AuthDatasource {
  static Future<Auth?> login(String email, String password) async {
    final baseUrl = dotenv.env['URL_BASE_APP'] ?? 'http://localhost:3000';
    final url = Uri.parse('$baseUrl/auth/login');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Auth.fromJson(data);
    }
    return null;
  }
}
