import 'package:flutter_test/flutter_test.dart';
import 'package:spotify_app_two/models/song_model.dart';

void main() {
  group('SongModel Tests', () {
    test('SongModel deserialization from JSON', () {
      final json = {
        'id': '123',
        'name': 'Test Song',
        'artist_name': 'Test Artist',
        'duration_ms': 180000,
        'preview_url': 'https://example.com/preview.mp3'
      };

      final song = SongModel.fromJson(json);

      expect(song.id, '123');
      expect(song.name, 'Test Song');
      expect(song.artistName, 'Test Artist');
      expect(song.durationMs, 180000);
      expect(song.previewUrl, 'https://example.com/preview.mp3');
    });

    test('SongModel serialization to JSON', () {
      final song = SongModel(
        id: '456',
        name: 'Another Song',
        artistName: 'Another Artist',
        durationMs: 240000,
        previewUrl: 'https://example.com/another.mp3',
      );

      final json = song.toJson();

      expect(json['id'], '456');
      expect(json['name'], 'Another Song');
      expect(json['artist_name'], 'Another Artist');
      expect(json['duration_ms'], 240000);
      expect(json['preview_url'], 'https://example.com/another.mp3');
    });
  });
}
