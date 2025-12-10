import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_urls.dart';
import '../models/song_model.dart';

class AlbumService {
  Future<Map<String, dynamic>?> getAlbumDetails(String albumId) async {
    try {
      final url = ApiUrls.albumDetails(albumId);
      final response = await http.get(Uri.parse(url));

      if (response.statusCode != 200) return null;

      final data = jsonDecode(response.body);

      final albumName = data["name"] ?? "";
      final albumImageUrl =
          (data["images"] != null && data["images"].isNotEmpty)
              ? data["images"][0]["url"] ?? ""
              : "";

      final trackItems = (data["tracks"]?["items"] ?? []) as List;
      List<SongModel> songs = [];

      for (final track in trackItems) {
        final artists = track["artists"] as List?;
        final firstArtist = (artists != null && artists.isNotEmpty)
            ? artists[0]["name"] ?? "Unknown Artist"
            : "Unknown Artist";

        songs.add(
          SongModel(
            id: track["id"] ?? "",
            name: track["name"] ?? "",
            artistName: firstArtist,
            durationMs: track["duration_ms"] ?? 0,
            previewUrl: track["preview_url"] ?? "",
          ),
        );
      }

      return {
        "albumName": albumName,
        "albumImageUrl": albumImageUrl,
        "songs": songs,
      };
    } catch (e) {
      print("AlbumService error: $e");
      return null;
    }
  }
}
