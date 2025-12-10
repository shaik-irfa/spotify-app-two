import 'package:json_annotation/json_annotation.dart';

part 'album_model.g.dart';

@JsonSerializable()
class AlbumModel {
  @JsonKey(name: "id")
  final String? id;

  @JsonKey(name: "name")
  final String? name;

  @JsonKey(name: "image_url")
  final String? imageUrl;

  AlbumModel({
    this.id,
    this.name,
    this.imageUrl,
  });

  factory AlbumModel.fromJson(Map<String, dynamic> json) =>
      _$AlbumModelFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumModelToJson(this);
}
