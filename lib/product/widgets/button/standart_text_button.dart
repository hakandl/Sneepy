import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../text/title_medium_text.dart';

class StandartTextButton extends StatelessWidget {
  const StandartTextButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.backgroundColor,
      this.isLoading});
  final String text;
  final Color? backgroundColor;
  final bool? isLoading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: context.lowBorderRadius,
        ),
        backgroundColor: backgroundColor ?? context.colorScheme.primary,
      ),
      onPressed: onPressed,
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 50,
        child: isLoading == true
            ? Padding(
                padding: context.paddingLow,
                child: CircularProgressIndicator(
                  color: context.colorScheme.onPrimary,
                ),
              )
            : TitleMediumText(
                text: text,
                color: context.colorScheme.onPrimary,
              ),
      ),
    );
  }
}
