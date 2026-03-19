import 'package:hive/hive.dart';

class LocalStorage {
  static const String boxName = 'app_storage';

  static final Box _box = Hive.box(boxName);
  
  static List<String> getList(String key) {
    final list = _box.get(key);
    if (list == null) return [];
    return List<String>.from(list);
  }

  static void saveList(String key, List<String> data) {
    _box.put(key, data);
  }
}