// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SongModel _$SongModelFromJson(Map<String, dynamic> json) => SongModel(
  id: json['id'] as String?,
  name: json['name'] as String?,
  artistName: json['artist_name'] as String?,
  durationMs: (json['duration_ms'] as num?)?.toInt(),
  previewUrl: json['preview_url'] as String?,
);

Map<String, dynamic> _$SongModelToJson(SongModel instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'artist_name': instance.artistName,
  'duration_ms': instance.durationMs,
  'preview_url': instance.previewUrl,
};
