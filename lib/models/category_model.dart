import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel {
  @JsonKey(name: "id")
  final String? id;

  @JsonKey(name: "name")
  final String? name;

  // Categories sometimes return images as icons[0].url
  @JsonKey(name: "image_url")
  final String? imageUrl;

  CategoryModel({
    this.id,
    this.name,
    this.imageUrl,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}
