import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = "http://192.168.1.2:8000";

  // Login
  static Future<Map<String, dynamic>> login(String mobile, String password) async {
    final url = Uri.parse("$baseUrl/api/login/");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"mobile": mobile, "password": password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data.containsKey("token")) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", data["token"]);
        await prefs.setString("mobile", mobile);
        return {"success": true, "token": data["token"]};
      }
      return {"success": false, "error": "Token not returned"};
    } else {
      final data = jsonDecode(response.body);
      return {"success": false, "error": data['error'] ?? "Login failed"};
    }
  }

  // Logout
  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
    await prefs.remove("mobile");
  }

  // Check login status
  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }

  static Future<String?> getMobile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("mobile");
  }
}
