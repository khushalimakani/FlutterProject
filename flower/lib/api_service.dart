import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://api.postman.com/collections/37029912-e6e1956e-4b7e-4740-b941-3082099ccd5a?access_key=PMAT-01J9BRH41SYMNG85N4GXWFH5EM';

  Future<dynamic> register(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // Parse the response if the status code is 200
      return jsonDecode(response.body);
    } else {
      // Handle errors or unexpected responses
      throw Exception('Failed to register: ${response.body}');
    }
  }

  Future<dynamic> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to login: ${response.body}');
    }
  }
}
