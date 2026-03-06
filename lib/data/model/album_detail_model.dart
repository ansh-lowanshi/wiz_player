import 'package:wiz_player/data/model/song_model.dart';
import 'package:wiz_player/domain/entities/album_detail_entity.dart';

class AlbumDetailModel extends AlbumDetailEntity {
  AlbumDetailModel({
    required super.id,
    required super.name,
    required super.url,
    required super.year,
    required super.language,
    required super.artistName,
    required super.imageUrl,
    required super.playCount,
    required super.songs,
  });

  factory AlbumDetailModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    final image = (data['image'] as List?) ?? [];
    final songs = (data['songs'] as List)
        .map((e) => SongModel.fromJson(e))
        .toList();

    return AlbumDetailModel(
      id: data['id'],
      name: data['name'],
      url: data['url'],
      year: data['year'],
      language: data['language'],
      artistName: data['artists']['primary'][0]['name'],
      imageUrl: image.isNotEmpty ? image.last['url'] : '',
      playCount: data['playCount'],
      songs: songs,
    );
  }
}
