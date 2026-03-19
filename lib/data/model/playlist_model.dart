import 'package:wiz_player/domain/entities/playlist_entity.dart';

class PlaylistModel extends PlayListEntity {
  PlaylistModel({
    required super.id,
    required super.name,
    required super.imageUrl,
    required super.language,
    required super.songCount,
  });

  factory PlaylistModel.fromJson(Map<String, dynamic> json) {
    final images = (json['image'] as List?) ?? [];
    return PlaylistModel(
      id: json['id'] as String,
      name: json['name'] as String,
      imageUrl: images.isNotEmpty ? images.last['url'] : '',
      language: json['language'] as String,
      songCount: json['songCount'],
    );
  }

  static List<PlaylistModel> fromList(List list) {
    return list
        .map((e) => PlaylistModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
