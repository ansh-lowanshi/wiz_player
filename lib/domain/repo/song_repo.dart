import 'dart:ffi';

import '../entities/song_entity.dart';

abstract class SongRepository {
  Future<List<SongEntity>> searchSongs(String query, {int? limit});
  Future<SongEntity> serchSongById(String id);
  Future<List<SongEntity>> songSuggestions(String id);
}
