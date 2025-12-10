import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spotify_app_two/services/api_urls.dart';
import 'package:spotify_app_two/models/playlist_model.dart';
import 'package:spotify_app_two/models/category_model.dart';
import 'package:spotify_app_two/models/album_model.dart';

class HomeService {
  // Get Featured Playlists
  Future<List<Playlist>> getFeaturedPlaylists() async {
    try {
      final response = await http.get(Uri.parse(ApiUrls.featuredPlaylists));
      final data = jsonDecode(response.body);

      List items = data["playlists"]["items"];

      return items.map((item) {
        return Playlist(
          id: item["id"] ?? "",
          name: item["name"] ?? "",
          description: item["description"] ?? "",
          imageUrl: item["images"] != null && item["images"].length > 0
              ? item["images"][0]["url"]
              : "",
        );
      }).toList();
    } catch (e) {
      return [];
    }
  }
 
  // Get Categories (Genres & Moods)
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await http.get(Uri.parse(ApiUrls.categories));
      final data = jsonDecode(response.body);

      List items = data["categories"]["items"];

      return items.map((item) {
        return CategoryModel(
          id: item["id"] ?? "",
          name: item["name"] ?? "",
          imageUrl: item["icons"] != null && item["icons"].length > 0
              ? item["icons"][0]["url"]
              : "",
        );
      }).toList();
    } catch (e) {
      return [];
    }
  }

  // Get New Releases
  Future<List<AlbumModel>> getNewReleases() async {
    try {
      final response = await http.get(Uri.parse(ApiUrls.newReleases));
      final data = jsonDecode(response.body);

      List items = data["albums"]["items"];

      return items.map((item) {
        return AlbumModel(
          id: item["id"] ?? "",
          name: item["name"] ?? "",
          imageUrl: item["images"] != null && item["images"].length > 0
              ? item["images"][0]["url"]
              : "",
        );
      }).toList();
    } catch (e) {
      return [];
    }
  }
}
