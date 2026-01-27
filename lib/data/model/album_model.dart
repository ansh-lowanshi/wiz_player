import '../../domain/entities/album_entity.dart';

class AlbumModel extends AlbumEntity {
  AlbumModel({
    required super.id,
    required super.name,
    required super.url,
    required super.year,
    required super.language,
    required super.artistName,
    required super.imageUrl,
    required super.playCount,
  });

  factory AlbumModel.fromJson(Map<String, dynamic> json) {
    final images = (json['image'] as List?) ?? [];
    final primaryArtists =
        (json['artists']?['primary'] as List?) ?? [];

    return AlbumModel(
      id: json['id'] as String,
      name: json['name'] as String,
      url: json['url'] as String,
      year: (json['year'] as num).toInt(),
      language: json['language'] as String,
      playCount: json['playCount'] as int?,
      artistName: primaryArtists.isNotEmpty
          ? primaryArtists.first['name']
          : 'Unknown',
      imageUrl: images.isNotEmpty
          ? images.last['url']
          : '',
    );
  }

  static List<AlbumModel> fromList(List list) {
    return list
        .map((e) => AlbumModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}