import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class TitleMediumText extends StatelessWidget {
  const TitleMediumText(
      {super.key, required this.text, this.color, this.fontWeight});
  final String text;
  final Color? color;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.textTheme.titleMedium?.copyWith(
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }
}
