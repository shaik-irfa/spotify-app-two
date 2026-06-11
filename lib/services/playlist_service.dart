import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_urls.dart';
import '../models/song_model.dart';
import '../utils/helpers.dart';

class PlaylistService {
  Future<Map<String, dynamic>?> getPlaylistDetails(String playlistId) async {
    try {
      final url = ApiUrls.playlistDetails(playlistId);
      final headers = await getAuthHeaders();
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode != 200) return null;

      final data = jsonDecode(response.body);

      final playlistName = data["name"] ?? "";
      final playlistImageUrl =
          (data["images"] != null && data["images"].isNotEmpty)
              ? (data["images"][0]["url"] ?? "")
              : "";

      final items = data["tracks"]["items"] as List;

      List<SongModel> songs = [];

      for (final item in items) {
        final track = item["track"];
        if (track == null) continue;

        final previewUrlStr = track["preview_url"];
        if (!isValidPreviewUrl(previewUrlStr)) {
          continue;
        }

        final artists = track["artists"] as List?;
        final firstArtist =
            (artists != null && artists.isNotEmpty && artists[0] != null)
                ? (artists[0]["name"] ?? "Unknown Artist")
                : "Unknown Artist";

        songs.add(
          SongModel(
            id: track["id"] ?? "",
            name: track["name"] ?? "",
            artistName: firstArtist,
            durationMs: track["duration_ms"] ?? 0,
            previewUrl: previewUrlStr,
          ),
        );
      }

      return {
        "playlistName": playlistName,
        "playlistImageUrl": playlistImageUrl,
        "songs": songs,
      };
    } catch (_) {
      return null;
    }
  }
}
