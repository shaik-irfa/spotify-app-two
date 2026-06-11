import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

const String loginUrl = "https://apis.ccbp.in/login";
const String featuredPlaylistsUrl = "https://apis2.ccbp.in/spotify-clone/featured-playlists";
const String categoriesUrl = "https://apis2.ccbp.in/spotify-clone/categories";
const String newReleasesUrl = "https://apis2.ccbp.in/spotify-clone/new-releases";

String playlistDetailsUrl(String playlistId) =>
    "https://apis2.ccbp.in/spotify-clone/playlists-details/$playlistId";
String categoryPlaylistsUrl(String categoryId) =>
    "https://apis2.ccbp.in/spotify-clone/category-playlists/$categoryId";
String albumDetailsUrl(String albumId) =>
    "https://apis2.ccbp.in/spotify-clone/album-details/$albumId";

bool isValidPreviewUrl(String? url) {
  if (url == null || url.trim().isEmpty) return false;
  final uri = Uri.tryParse(url);
  if (uri == null) return false;
  return uri.hasScheme &&
      (uri.scheme == 'http' || uri.scheme == 'https') &&
      uri.host.isNotEmpty;
}

void main() async {
  print("Logging in to obtain JWT token...");
  final loginResponse = await http.post(
    Uri.parse(loginUrl),
    headers: {"Content-Type": "text/plain"},
    body: jsonEncode({"username": "rahul", "password": "rahul@2021"}),
  ).timeout(const Duration(seconds: 10));

  if (loginResponse.statusCode != 200) {
    print("Failed to log in: ${loginResponse.body}");
    exit(1);
  }

  final loginData = jsonDecode(loginResponse.body);
  final token = loginData["jwt_token"];
  print("JWT Token acquired successfully.");

  final headers = {
    "Authorization": "Bearer $token",
    "Content-Type": "application/json",
  };

  final Map<String, Map<String, dynamic>> analyzedTracks = {};

  // 1. Fetch Featured Playlists
  print("Fetching featured playlists...");
  final Set<String> playlistIds = {};
  try {
    final fpRes = await http.get(Uri.parse(featuredPlaylistsUrl), headers: headers)
        .timeout(const Duration(seconds: 8));
    if (fpRes.statusCode == 200) {
      final data = jsonDecode(fpRes.body);
      if (data != null && data["playlists"] != null && data["playlists"]["items"] != null) {
        for (final item in data["playlists"]["items"]) {
          if (item != null && item["id"] != null) {
            playlistIds.add(item["id"]);
          }
        }
      }
    }
  } catch (e) {
    print("Error fetching featured playlists: $e");
  }

  // 2. Fetch Categories and Playlists inside the first 3 categories to limit requests
  print("Fetching categories...");
  try {
    final catRes = await http.get(Uri.parse(categoriesUrl), headers: headers)
        .timeout(const Duration(seconds: 8));
    if (catRes.statusCode == 200) {
      final data = jsonDecode(catRes.body);
      if (data != null && data["categories"] != null && data["categories"]["items"] != null) {
        final List categories = data["categories"]["items"];
        // Process only first 3 categories to avoid overwhelming mock API
        final limitCategories = categories.take(3);
        for (final cat in limitCategories) {
          if (cat == null) continue;
          final catId = cat["id"];
          if (catId != null) {
            print("Fetching playlists for category: $catId...");
            try {
              final catPlayRes = await http.get(Uri.parse(categoryPlaylistsUrl(catId)), headers: headers)
                  .timeout(const Duration(seconds: 5));
              if (catPlayRes.statusCode == 200) {
                final catPlayData = jsonDecode(catPlayRes.body);
                if (catPlayData != null && catPlayData["playlists"] != null && catPlayData["playlists"]["items"] != null) {
                  for (final item in catPlayData["playlists"]["items"]) {
                    if (item != null && item["id"] != null) {
                      playlistIds.add(item["id"]);
                    }
                  }
                }
              }
            } catch (e) {
              print("Error fetching playlists for category $catId: $e");
            }
          }
        }
      }
    }
  } catch (e) {
    print("Error fetching categories: $e");
  }

  // 3. Fetch New Releases (Albums)
  print("Fetching new releases...");
  final Set<String> albumIds = {};
  try {
    final nrRes = await http.get(Uri.parse(newReleasesUrl), headers: headers)
        .timeout(const Duration(seconds: 8));
    if (nrRes.statusCode == 200) {
      final data = jsonDecode(nrRes.body);
      if (data != null && data["albums"] != null && data["albums"]["items"] != null) {
        for (final item in data["albums"]["items"]) {
          if (item != null && item["id"] != null) {
            albumIds.add(item["id"]);
          }
        }
      }
    }
  } catch (e) {
    print("Error fetching new releases: $e");
  }

  // 4. Fetch details for each playlist and verify tracks
  print("Processing ${playlistIds.length} playlists...");
  int playlistCount = 0;
  for (final playlistId in playlistIds) {
    playlistCount++;
    print("[$playlistCount/${playlistIds.length}] Fetching details for playlist: $playlistId...");
    try {
      final detailRes = await http.get(Uri.parse(playlistDetailsUrl(playlistId)), headers: headers)
          .timeout(const Duration(seconds: 4));
      if (detailRes.statusCode == 200) {
        final data = jsonDecode(detailRes.body);
        if (data != null && data["tracks"] != null && data["tracks"]["items"] != null) {
          final tracks = data["tracks"]["items"];
          for (final item in tracks) {
            if (item == null) continue;
            final track = item["track"];
            if (track == null || track["id"] == null) continue;
            final trackId = track["id"];
            final trackName = track["name"] ?? "Unknown Track";
            final artist = (track["artists"] != null && track["artists"].isNotEmpty)
                ? track["artists"][0]["name"]
                : "Unknown Artist";
            final previewUrl = track["preview_url"];

            analyzedTracks[trackId] = {
              "name": trackName,
              "artist": artist,
              "preview_url": previewUrl,
              "source": "Playlist ($playlistId)",
            };
          }
        }
      }
    } catch (e) {
      print("Warning: failed to fetch details for playlist $playlistId: $e");
    }
  }

  // 5. Fetch details for each album and verify tracks
  print("Processing ${albumIds.length} albums...");
  int albumCount = 0;
  for (final albumId in albumIds) {
    albumCount++;
    print("[$albumCount/${albumIds.length}] Fetching details for album: $albumId...");
    try {
      final detailRes = await http.get(Uri.parse(albumDetailsUrl(albumId)), headers: headers)
          .timeout(const Duration(seconds: 4));
      if (detailRes.statusCode == 200) {
        final data = jsonDecode(detailRes.body);
        if (data != null && data["tracks"] != null && data["tracks"]["items"] != null) {
          final tracks = data["tracks"]["items"];
          for (final track in tracks) {
            if (track == null || track["id"] == null) continue;
            final trackId = track["id"];
            final trackName = track["name"] ?? "Unknown Track";
            final artist = (track["artists"] != null && track["artists"].isNotEmpty)
                ? track["artists"][0]["name"]
                : "Unknown Artist";
            final previewUrl = track["preview_url"];

            if (!analyzedTracks.containsKey(trackId)) {
              analyzedTracks[trackId] = {
                "name": trackName,
                "artist": artist,
                "preview_url": previewUrl,
                "source": "Album ($albumId)",
              };
            }
          }
        }
      }
    } catch (e) {
      print("Warning: failed to fetch details for album $albumId: $e");
    }
  }

  // Generate statistics
  int totalTracks = analyzedTracks.length;
  int validCount = 0;
  int missingCount = 0;
  int invalidCount = 0;

  final List<String> validList = [];
  final List<String> missingList = [];
  final List<String> invalidList = [];

  analyzedTracks.forEach((id, track) {
    final String name = track["name"];
    final String artist = track["artist"];
    final dynamic previewUrl = track["preview_url"];
    final String source = track["source"];

    if (previewUrl == null || previewUrl.toString().trim().isEmpty) {
      missingCount++;
      missingList.add("- **$name** by *$artist* (ID: $id, Source: $source)");
    } else if (!isValidPreviewUrl(previewUrl.toString())) {
      invalidCount++;
      invalidList.add("- **$name** by *$artist* (ID: $id, Invalid URL: `$previewUrl`, Source: $source)");
    } else {
      validCount++;
      validList.add("- **$name** by *$artist* (ID: $id, URL: `$previewUrl`, Source: $source)");
    }
  });

  // Write Markdown report
  final buffer = StringBuffer();
  buffer.writeln("# Spotify Remix Preview URL Verification Report");
  buffer.writeln();
  buffer.writeln("Generated on: ${DateTime.now().toUtc().toIso8601String()} UTC");
  buffer.writeln();
  buffer.writeln("## Summary Statistics");
  buffer.writeln();
  buffer.writeln("| Metric | Count | Percentage |");
  buffer.writeln("| :--- | :---: | :---: |");
  buffer.writeln("| **Total Unique Tracks Checked** | $totalTracks | 100.0% |");
  buffer.writeln("| **Tracks with Valid Previews** | $validCount | ${(validCount / totalTracks * 100).toStringAsFixed(1)}% |");
  buffer.writeln("| **Tracks with Missing Previews** (Null/Empty) | $missingCount | ${(missingCount / totalTracks * 100).toStringAsFixed(1)}% |");
  buffer.writeln("| **Tracks Hidden Due to Invalid Previews** (Malformed URLs) | $invalidCount | ${(invalidCount / totalTracks * 100).toStringAsFixed(1)}% |");
  buffer.writeln();
  buffer.writeln("---");
  buffer.writeln();
  buffer.writeln("## Details");
  buffer.writeln();
  buffer.writeln("### Tracks Hidden Due to Invalid Previews ($invalidCount)");
  if (invalidList.isEmpty) {
    buffer.writeln("None.");
  } else {
    buffer.writeln(invalidList.join("\n"));
  }
  buffer.writeln();
  buffer.writeln("### Tracks with Missing Previews (Null/Empty) ($missingCount)");
  if (missingList.isEmpty) {
    buffer.writeln("None.");
  } else {
    buffer.writeln(missingList.join("\n"));
  }
  buffer.writeln();
  buffer.writeln("### Tracks with Valid Previews ($validCount)");
  if (validList.isEmpty) {
    buffer.writeln("None.");
  } else {
    buffer.writeln(validList.join("\n"));
  }

  final reportFile = File("preview_report.md");
  await reportFile.writeAsString(buffer.toString());
  print("\nReport successfully generated at: ${reportFile.absolute.path}");
  print("Total unique tracks checked: $totalTracks");
  print("Valid previews: $validCount");
  print("Missing previews (Null/Empty): $missingCount");
  print("Invalid previews (Hidden): $invalidCount");
}
