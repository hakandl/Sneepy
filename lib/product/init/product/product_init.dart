import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sneepy/product/cache/hive_manager.dart';
import 'package:sneepy/product/init/language/localization_init.dart';
import 'package:sneepy/product/init/product/notification_init.dart';
import 'package:sneepy/product/init/product/revenuecat_init.dart';

class ProductInit {
  final localizationInit = LocalizationInit();

  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
    await HiveManager.init(boxName: BoxNames.settings.name);
    await RevenueCatInit().init();
    await NotificationInit().init();
  }
}
