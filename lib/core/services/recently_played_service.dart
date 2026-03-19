import 'package:wiz_player/core/storage/local_storage.dart';

class RecentlyPlayedService {
  static const String key = "recently_played";

  List<String> getSongs() {
    return LocalStorage.getList(key);
  }

  void addSong(String songId) {
    List<String> songs = getSongs();

    songs.remove(songId);
    songs.insert(0, songId);

    if (songs.length > 20) {
      songs = songs.sublist(0, 20);
    }

    LocalStorage.saveList(key, songs);
  }
}
