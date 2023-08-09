import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:sneepy/product/constants/strings.dart';
import 'package:sneepy/product/init/language/locale_keys.g.dart';
import 'package:sneepy/product/widgets/button/standart_text_button.dart';

Future<T?> showStandartDialog<T>(
  BuildContext context, {
  String? title,
  Widget? content,
  VoidCallback? onPressed,
  String? buttonText,
  Color? buttonColor,
}) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          title ?? AppStrings.empty,
        ),
        content: content,
        actions: [
          StandartTextButton(
            text: buttonText ?? LocaleKeys.buttons_gotIt.tr(),
            backgroundColor: buttonColor,
            onPressed: () => onPressed ?? context.pop(),
          )
        ],
      );
    },
  );
}
