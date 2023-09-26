import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:sneepy/feature/splash/view/splash_view.dart';
import 'package:sneepy/product/init/product/product_init.dart';
import 'package:sneepy/product/init/string/string.dart';
import 'package:sneepy/product/init/theme/theme.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  final productInit = ProductInit();
  await productInit.init();

  runApp(
    EasyLocalization(
      supportedLocales: productInit.localizationInit.supportedLocales,
      path: productInit.localizationInit.path,
      child: ShowCaseWidget(
        builder: Builder(
          builder: (context) => const SneepyApp(),
        ),
      ),
    ),
  );
}

class SneepyApp extends StatelessWidget {
  const SneepyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: SneepyStringsInit.APP_NAME,
      home: const SplashView(),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: SneepyTheme(context).theme,
      navigatorKey: navigatorKey,
    );
  }
}
