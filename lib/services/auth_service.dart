import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  Future<Map<String, dynamic>> login({
    required String username,
    required String password,
  }) async {
    const url = "https://apis.ccbp.in/login";

    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "username": username,
        "password": password,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 && data["jwt_token"] != null) {
      return {"success": true, "token": data["jwt_token"]};
    } else {
      return {
        "success": false,
        "message": data["error_msg"] ?? "Login failed"
      };
    }
  }
}
