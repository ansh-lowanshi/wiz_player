import 'package:hive/hive.dart';

class FrequentPlayedService {
  static const String boxName = 'app_storage';
  static const String key = "play_count";

  static final Box _box = Hive.box(boxName);

  Map<String, int> _getMap() {
    final raw = _box.get(key);
    if (raw == null) return {};
    return Map<String, int>.from(raw);
  }

  void incrementPlay(String songId) {
    final map = _getMap();

    if (map.containsKey(songId)) {
      map[songId] = map[songId]! + 1;
    } else {
      map[songId] = 1;
    }

    if (map.length > 50) {
      map.remove(map.keys.first);
    }

    _box.put(key, map);
  }

  List<String> getMostPlayed() {
    final map = _getMap();
    final filtered = map.entries.where((e) => e.value >= 2).toList();
    filtered.sort((a, b) => b.value.compareTo(a.value));
    return filtered.map((e) => e.key).toList();
  }

  List<String> getSoundTrack() {
    final map = _getMap();

    final result = <String>[];

    for (final entry in map.entries) {
      result.add(entry.key);
      if (result.length == 15) {
        break;
      }
    }

    return result;
  }
}
