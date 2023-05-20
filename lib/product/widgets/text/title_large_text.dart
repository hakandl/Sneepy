import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class TitleLargeText extends StatelessWidget {
  const TitleLargeText({super.key, required this.text, this.color});
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.textTheme.titleLarge?.copyWith(
        color: color,
      ),
    );
  }
}
