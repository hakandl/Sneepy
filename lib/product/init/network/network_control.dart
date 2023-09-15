import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sneepy/main.dart';
import 'package:sneepy/product/init/language/locale_keys.g.dart';
import 'package:sneepy/product/widgets/dialog/standart_dialog.dart';

class NetworkControl {
  static Future<bool> isInternetConnected() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  static Future<void> showNoInternetDialog() async {
    await showStandartDialog(
      navigatorKey.currentContext!,
      title: LocaleKeys.noInternetConnection.tr(),
      content: Text(
        LocaleKeys.pleaseCheckYourInternetConnection.tr(),
      ),
    );
  }
}
