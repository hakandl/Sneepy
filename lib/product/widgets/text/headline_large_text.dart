import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class HeadlineLargeText extends StatelessWidget {
  const HeadlineLargeText({super.key, required this.text, this.color});
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.textTheme.headlineLarge?.copyWith(
        color: color,
      ),
    );
  }
}
