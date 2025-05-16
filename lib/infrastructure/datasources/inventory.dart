import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/auth.dart';

class InventoryService {
  static Future<List<Product>> fetchInventory() async {
    final baseUrl = dotenv.env['URL_BASE_APP']!;
    final url = Uri.parse('$baseUrl/inventory');

    final prefs = await SharedPreferences.getInstance();
    final authString = prefs.getString('auth');

    if (authString == null) {
      throw Exception('Usuario no autenticado. No se encontró el token.');
    }

    final authJson = jsonDecode(authString);
    final auth = Auth.fromJson(authJson);
    final token = auth.token;

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List jsonList = jsonDecode(response.body);
      return jsonList.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Error al cargar inventario: ${response.statusCode} - ${response.body}');
    }
  }
}
