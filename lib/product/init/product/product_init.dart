import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sneepy/product/cache/hive_manager.dart';
import 'package:sneepy/product/init/language/localization_init.dart';
import 'package:sneepy/product/init/product/firebase_settings.dart';
import 'package:sneepy/product/init/product/revenuecat_init.dart';

class ProductInit {
  final localizationInit = LocalizationInit();

  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
    await RevenueCatInit().init();
    await FirebaseSettings().init();
    await HiveManager.init(boxName: BoxNames.settings.name);
  }
}
