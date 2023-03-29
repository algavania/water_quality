import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkService {
  static String baseUrl = 'https://good-ponds-lxz6xwlfka-et.a.run.app/v1';
  static Map<String, String> headers = {
    "Accept": "application/json",
    'Content-Type': 'application/json'
  };

  static Future<http.Response> get(String endpoint) async {
    final res = await http.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: headers
    );
    return res;
  }

  static Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    final res = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: headers,
        body: jsonEncode(body)
    );
    return res;
  }
}