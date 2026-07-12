import 'dart:convert';
import 'package:http/http.dart' as http;

const String backendBaseUrl = 'https://trader-camp-intelligence-bot-prod.railway.app';

class ApiClient {
  static String? authToken;

  static Future<String> googleLogin(String accessToken) async {
    final uri = Uri.parse('$backendBaseUrl/auth/callback?code=$accessToken');
    final res = await http.get(uri);
    if (res.statusCode != 200) throw Exception('Login failed');
    final body = jsonDecode(res.body) as Map<String, dynamic>;
    authToken = body['token'];
    return body['user']['id'];
  }
}
