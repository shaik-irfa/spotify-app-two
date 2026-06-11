import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_urls.dart';
import '../utils/helpers.dart';

class CategoryService {
  Future<List<Map<String, String>>> getCategoryPlaylists(String categoryId) async {
    try {
      final url = ApiUrls.categoryPlaylists(categoryId);
      final headers = await getAuthHeaders();
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode != 200) return [];

      final data = jsonDecode(response.body);
      final List items = data["playlists"]["items"];

      return items.map<Map<String, String>>((item) {
        final imageUrl = item["images"] != null && item["images"].isNotEmpty
            ? item["images"][0]["url"] ?? ""
            : "";

        final totalTracks = item["tracks"]?["total"] ?? 0;

        return {
          "id": item["id"] ?? "",
          "name": item["name"] ?? "",
          "image": imageUrl,
          "totalTracks": totalTracks.toString(),
        };
      }).toList();
    } catch (e) {
      return [];
    }
  }
}
