import 'package:wiz_player/data/model/album_model.dart';
import 'package:wiz_player/data/model/song_model.dart';

class ArtistDetailEntity {
  final String id;
  final String name;
  final String imageUrl;
  final String url;
  final List<AlbumModel> albums;
  final List<SongModel> songs;

  const ArtistDetailEntity({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.url,
    required this.albums,
    required this.songs,
  });
}