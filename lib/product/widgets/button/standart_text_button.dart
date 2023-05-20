import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:sneepy/product/constant/colors.dart';

class StandartTextButton extends StatelessWidget {
  const StandartTextButton({super.key, required this.text, required this.onPressed, this.backgroundColor});
  final String text;
  final Color? backgroundColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: context.lowBorderRadius,
        ),
        backgroundColor: backgroundColor ?? AppColors.blueRibbon,
      ),
      onPressed: onPressed,
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 50,
        child: Text(
          text,
          style: context.textTheme.titleMedium?.copyWith(
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
