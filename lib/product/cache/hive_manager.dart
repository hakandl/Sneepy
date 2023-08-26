import 'package:hive_flutter/hive_flutter.dart';

enum BoxNames {
  settings,
}

enum BoxKeyNames {
  token,
  fcmToken,
  age,
  gender,
  country,
}

class HiveManager {
  static late Box _box;

  static Future<void> init({required String boxName}) async {
    await Hive.initFlutter();
    _box = await Hive.openBox(boxName);
  }

  static Future<void> save({required String key, required String value}) async {
    await _box.put(key, value);
  }

  static String? get({required String key}) {
    return _box.get(key);
  }
}
