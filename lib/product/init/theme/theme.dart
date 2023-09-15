import 'package:flutter/material.dart';
import 'package:sneepy/product/constants/enums/number.dart';
import 'package:sneepy/product/init/theme/theme_colors.dart';

class SneepyTheme {
  late ThemeData theme;
  final SneepyThemeColors sneepyThemeColors = SneepyThemeColors();

  SneepyTheme(BuildContext context) {
    theme = ThemeData(
      useMaterial3: true,
      colorScheme: _colorScheme,
      scaffoldBackgroundColor: sneepyThemeColors.background,
      bottomSheetTheme: _bottomSheetTheme,
      appBarTheme: _appBar(context),
    );
  }

  ColorScheme get _colorScheme => ColorScheme(
        brightness: sneepyThemeColors.brightnessLight,
        primary: sneepyThemeColors.blueRibbon,
        onPrimary: sneepyThemeColors.white,
        secondary: sneepyThemeColors.caribbeanGreen,
        onSecondary: sneepyThemeColors.caribbeanGreen,
        error: sneepyThemeColors.persimmon,
        onError: sneepyThemeColors.persimmon,
        background: sneepyThemeColors.athensGray,
        onBackground: sneepyThemeColors.background,
        surface: sneepyThemeColors.ebonyClay,
        onSurface: sneepyThemeColors.ebonyClay,
      );

  BottomSheetThemeData get _bottomSheetTheme => BottomSheetThemeData(
        backgroundColor: sneepyThemeColors.white,
      );

  AppBarTheme _appBar(BuildContext context) {
    return AppBarTheme(
      centerTitle: true,
      backgroundColor: sneepyThemeColors.blueRibbon,
      scrolledUnderElevation: NumberEnum.ten.value,
      iconTheme: IconThemeData(
        color: sneepyThemeColors.white,
      ),
      actionsIconTheme: IconThemeData(
        color: sneepyThemeColors.white,
      ),
      titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: sneepyThemeColors.white,
          ),
    );
  }
}
