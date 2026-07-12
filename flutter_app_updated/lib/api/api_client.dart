import 'dart:convert';
import 'package:http/http.dart' as http;

// 改成你的 Railway URL（完成部署後替換）
const String backendBaseUrl = 'https://trading-assistant-backend-xxx.railway.app';

class ApiClient {
  static String? authToken;

  // Google OAuth 登入
  static Future<String> googleLogin(String accessToken) async {
    final uri = Uri.parse('$backendBaseUrl/auth/callback?code=$accessToken');
    final res = await http.get(uri);
    _checkOk(res);
    final body = jsonDecode(res.body) as Map<String, dynamic>;
    authToken = body['token'];
    return body['user']['id'];
  }

  // 搜尋商品
  static Future<List<dynamic>> searchInstruments(String query) async {
    final uri = Uri.parse('$backendBaseUrl/api/market/instruments/search?q=$query');
    final res = await http.get(uri, headers: _authHeaders());
    _checkOk(res);
    return jsonDecode(res.body) as List<dynamic>;
  }

  // 自選股列表
  static Future<List<dynamic>> getWatchlists() async {
    final uri = Uri.parse('$backendBaseUrl/api/watchlists');
    final res = await http.get(uri, headers: _authHeaders());
    _checkOk(res);
    return jsonDecode(res.body) as List<dynamic>;
  }

  // 建立自選股分類
  static Future<String> createWatchlist(String name) async {
    final uri = Uri.parse('$backendBaseUrl/api/watchlists');
    final res = await http.post(uri,
        headers: _authHeaders(),
        body: jsonEncode({'name': name}));
    _checkOk(res, expect: 201);
    return (jsonDecode(res.body) as Map<String, dynamic>)['id'] as String;
  }

  // 加入自選股
  static Future<void> addWatchlistItem(String watchlistId, String instrumentId, {String? note}) async {
    final uri = Uri.parse('$backendBaseUrl/api/watchlists/$watchlistId/items');
    final res = await http.post(uri,
        headers: _authHeaders(),
        body: jsonEncode({'instrument_id': instrumentId, 'status': 'watching', 'note': note}));
    _checkOk(res, expect: 201);
  }

  // 建立交易計畫
  static Future<(bool, String?)> createTradePlan(Map<String, dynamic> body) async {
    final uri = Uri.parse('$backendBaseUrl/api/trade-plans');
    final res = await http.post(uri,
        headers: _authHeaders(),
        body: jsonEncode(body));
    if (res.statusCode == 201) return (true, null);
    final decoded = jsonDecode(res.body) as Map<String, dynamic>;
    return (false, decoded['error']?.toString() ?? '未知錯誤');
  }

  // 建立交易紀錄
  static Future<(bool, String?)> createTradeRecord(Map<String, dynamic> body) async {
    final uri = Uri.parse('$backendBaseUrl/api/trade-records');
    final res = await http.post(uri,
        headers: _authHeaders(),
        body: jsonEncode(body));
    if (res.statusCode == 201) return (true, null);
    final decoded = jsonDecode(res.body) as Map<String, dynamic>;
    return (false, decoded['error']?.toString() ?? '未知錯誤');
  }

  // 取得進行中的挑戰
  static Future<List<dynamic>> getActiveChallenges(String date) async {
    final uri = Uri.parse('$backendBaseUrl/api/challenges/active?date=$date');
    final res = await http.get(uri, headers: _authHeaders());
    _checkOk(res);
    return jsonDecode(res.body) as List<dynamic>;
  }

  // 建立挑戰
  static Future<String> createChallenge(String title, String category, String startDate) async {
    final uri = Uri.parse('$backendBaseUrl/api/challenges');
    final res = await http.post(uri,
        headers: _authHeaders(),
        body: jsonEncode({'title': title, 'category': category, 'start_date': startDate}));
    _checkOk(res, expect: 201);
    return (jsonDecode(res.body) as Map<String, dynamic>)['id'] as String;
  }

  static Map<String, String> _authHeaders() {
    return {
      'Content-Type': 'application/json',
      if (authToken != null) 'Authorization': 'Bearer $authToken',
    };
  }

  static void _checkOk(http.Response res, {int expect = 200}) {
    if (res.statusCode != expect) {
      throw Exception('API 錯誤 (${res.statusCode}): ${res.body}');
    }
  }
}
