import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:sneepy/feature/auth/login/view/login_view.dart';
import 'package:sneepy/product/constant/colors.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: LoginView(),
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: AppColors.blueRibbon,
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: AppColors.blueRibbon,
          toolbarHeight: 64,
          scrolledUnderElevation: 15,
          iconTheme: const IconThemeData(
            color: AppColors.white,
          ),
          actionsIconTheme: const IconThemeData(
            color: AppColors.white,
          ),
          titleTextStyle: context.textTheme.titleLarge?.copyWith(
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
