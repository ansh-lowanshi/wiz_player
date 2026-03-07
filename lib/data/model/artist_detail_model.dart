import 'package:wiz_player/data/model/album_model.dart';
import 'package:wiz_player/data/model/song_model.dart';
import 'package:wiz_player/domain/entities/artist_detail_entity.dart';

class ArtistDetailModel extends ArtistDetailEntity {
  ArtistDetailModel({
    required super.id,
    required super.name,
    required super.imageUrl,
    required super.url,
    required super.songs,
    required super.albums,
  });

  factory ArtistDetailModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    final images = (data['image'] as List?) ?? [];
    final songs = (data['topSongs'] as List? ?? [])
        .map((e) => SongModel.fromJson(e))
        .toList();
    final albums = (data['topAlbums'] as List? ?? [])
        .map((e) => AlbumModel.fromJson(e))
        .toList();

    return ArtistDetailModel(
      id: data['id'] as String? ?? 'Unknown',
      name: data['name'] as String? ?? 'Unknown',
      url: data['url'] as String? ?? 'Unknown',
      imageUrl: images.isNotEmpty ? images.last['url'] : '',
      songs: songs,
      albums: albums,
    );
  }
}
