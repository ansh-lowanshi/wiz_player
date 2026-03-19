import 'package:wiz_player/domain/entities/song_entity.dart';

class PlaylistDetailEntity {
  final String id;
  final String name;
  final String url;
  // final String? year;
  final String language;
  final String artistName;
  final String imageUrl;
  final String? playCount;
  final List<SongEntity> songs;

  const PlaylistDetailEntity({
    required this.id,
    required this.name,
    required this.url,
    // required this.year,
    required this.language,
    required this.artistName,
    required this.imageUrl,
    required this.playCount,
    required this.songs,
  });

  
}