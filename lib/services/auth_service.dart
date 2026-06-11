import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<Map<String, dynamic>> login({
    required String username,
    required String password,
  }) async {
    const url = "https://apis.ccbp.in/login";

    try {
      final requestBody = jsonEncode({
        "username": username,
        "password": password,
      });
      debugPrint("LOGIN URL: $url");
      debugPrint("REQUEST BODY: $requestBody");

      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "text/plain"},
        body: requestBody,
      ).timeout(const Duration(seconds: 15));

      debugPrint("STATUS CODE: ${response.statusCode}");
      debugPrint("RESPONSE BODY: ${response.body}");

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data["jwt_token"] != null) {
        return {"success": true, "token": data["jwt_token"]};
      } else {
        return {
          "success": false,
          "message": data["error_msg"] ?? "Login failed"
        };
      }
    } catch (e, stack) {
      debugPrint("ERROR: $e");
      debugPrintStack(stackTrace: stack);
      return {
        "success": false,
        "message": "Network error or connection timed out. Please try again."
      };
    }
  }
}
