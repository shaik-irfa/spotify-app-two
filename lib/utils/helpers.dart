import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, String>> getAuthHeaders() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString("jwt_token") ?? "";
  return {
    "Authorization": "Bearer $token",
    "Content-Type": "application/json",
  };
}

bool isValidPreviewUrl(String? url) {
  if (url == null || url.trim().isEmpty) return false;
  final uri = Uri.tryParse(url);
  if (uri == null) return false;
  return uri.hasScheme &&
      (uri.scheme == 'http' || uri.scheme == 'https') &&
      uri.host.isNotEmpty;
}

