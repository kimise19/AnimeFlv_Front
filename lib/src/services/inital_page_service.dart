import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<Map<String, dynamic>> fetchInitialData() async {
    final response =
        await http.get(Uri.parse('http://192.168.0.108:4000/get_initial_page'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
