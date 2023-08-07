import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:sneepy/product/constants/strings.dart';
import 'package:sneepy/product/widgets/button/standart_text_button.dart';

Future<T?> showStandartDialog<T>(
  BuildContext context, {
  String? title,
  Widget? content,
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
            text: 'Anladım',
            onPressed: () => context.pop(),
          )
        ],
      );
    },
  );
}
