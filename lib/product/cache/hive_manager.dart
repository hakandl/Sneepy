import 'package:hive_flutter/hive_flutter.dart';

enum BoxNames {
  settings,
}

enum BoxKeyNames {
  token,
  deviceToken,
  age,
  gender,
  country,
  locale,
  showcase,
}

class HiveManager {
  static late Box _box;

  static Future<void> init({required String boxName}) async {
    await Hive.initFlutter();
    _box = await Hive.openBox(boxName);
  }

  static Future<void> save(
      {required dynamic key, required dynamic value}) async {
    await _box.put(key, value);
  }

  static dynamic get({required dynamic key}) {
    return _box.get(key);
  }

  static Future<void> delete({required dynamic key}) async {
    await _box.delete(key);
  }
}
