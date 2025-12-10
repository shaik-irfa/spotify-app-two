import 'package:json_annotation/json_annotation.dart';

part 'song_model.g.dart';

@JsonSerializable()
class SongModel {
  @JsonKey(name: "id")
  final String? id;

  @JsonKey(name: "name")
  final String? name;

  // Artist name (inside artists list in API)
  @JsonKey(name: "artist_name")
  final String? artistName;

  // Duration in milliseconds (from API)
  @JsonKey(name: "duration_ms")
  final int? durationMs;

  // Audio preview URL for playing the song
  @JsonKey(name: "preview_url")
  final String? previewUrl;

  SongModel({
    this.id,
    this.name,
    this.artistName,
    this.durationMs,
    this.previewUrl,
  });

  factory SongModel.fromJson(Map<String, dynamic> json) =>
      _$SongModelFromJson(json);

  Map<String, dynamic> toJson() => _$SongModelToJson(this);
}
