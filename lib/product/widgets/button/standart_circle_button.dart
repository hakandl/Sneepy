import 'package:flutter/material.dart';

class StandartCircleButton extends StatelessWidget {
  const StandartCircleButton({super.key, required this.child, required this.onPressed, this.backgroundColor});
  final Widget? child;
  final Color? backgroundColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        fixedSize: const Size(70, 70),
        backgroundColor: backgroundColor,
      ),
      onPressed: onPressed,
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 50,
        child: child,
      ),
    );
  }
}
