import '../../domain/entities/song_entity.dart';

class SongModel extends SongEntity {
  SongModel({
    required super.id,
    required super.name,
    required super.duration,
    required super.language,
    required super.label,
    required super.playCount,
    required super.albumName,
    required super.artistName,
    required super.imageUrl,
    required super.audioUrl,
  });

  factory SongModel.fromJson(Map<String, dynamic> json) {
    final images = (json['image'] as List?) ?? [];
    final downloads = (json['downloadUrl'] as List?) ?? [];
    final primaryArtists =
        (json['artists']?['primary'] as List?) ?? [];

    return SongModel(
      id: json['id'] as String,
      name: json['name'] as String,
      duration: (json['duration'] as num).toInt(),
      language: json['language'] as String,
      label: json['label'] as String? ?? 'Unknown',
      playCount: json['playCount'] as int?,
      albumName: json['album']?['name'] ?? 'Unknown',
      artistName: primaryArtists.isNotEmpty
          ? primaryArtists.first['name']
          : 'Unknown',
      imageUrl: images.isNotEmpty
          ? images.last['url']
          : '',
      audioUrl: downloads.isNotEmpty
          ? downloads.last['url']
          : '',
    );
  }

  static List<SongModel> fromList(List list) {
    return list
        .map((e) => SongModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}