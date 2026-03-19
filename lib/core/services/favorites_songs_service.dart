import 'package:wiz_player/core/storage/local_storage.dart';

class FavoritesSongsService {
  static const key = "favoritesSongs";

  List<String> getSongs() => LocalStorage.getList(key);

  void add(String songId) {
    final songs = getSongs();
    if (!songs.contains(songId)) {
      songs.add(songId);
      LocalStorage.saveList(key, songs);
    }
  }
}
