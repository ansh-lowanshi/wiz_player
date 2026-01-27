import '../entities/song_entity.dart';

abstract class SongRepository {
  Future<List<SongEntity>> searchSongs(
    String query, {
    int limit = 10,
  });
}