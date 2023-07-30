import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sneepy/product/init/language/localization_init.dart';

class ProductInit {
  final localizationInit = LocalizationInit();

  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
  }
}
