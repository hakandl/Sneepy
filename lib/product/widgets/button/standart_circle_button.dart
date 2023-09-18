import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:sneepy/product/constants/enums/number.dart';

class StandartCircleButton extends StatelessWidget {
  const StandartCircleButton(
      {super.key,
      required this.child,
      required this.onPressed,
      this.backgroundColor});
  final Widget? child;
  final Color? backgroundColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        fixedSize: Size(NumberEnum.seventy.value, NumberEnum.seventy.value),
        backgroundColor: backgroundColor,
        padding: EdgeInsets.zero,
        side: BorderSide(
          color: context.colorScheme.onPrimary,
          width: NumberEnum.four.value,
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: NumberEnum.fifty.value,
        child: child,
      ),
    );
  }
}
