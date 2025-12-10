import 'package:json_annotation/json_annotation.dart';

part 'playlist_model.g.dart';

@JsonSerializable()
class Playlist {
  @JsonKey(name: "id")
  final String? id;

  @JsonKey(name: "name")
  final String? name;

  @JsonKey(name: "description")
  final String? description;

  @JsonKey(name: "image_url")
  final String? imageUrl;

  Playlist({
    this.id,
    this.name,
    this.description,
    this.imageUrl,
  });

  factory Playlist.fromJson(Map<String, dynamic> json) =>
      _$PlaylistFromJson(json);

  Map<String, dynamic> toJson() => _$PlaylistToJson(this);
}
