import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:sneepy/product/constant/colors.dart';

class StandartTextField extends StatelessWidget {
  const StandartTextField({super.key, required this.text, this.obscureText, this.suffix, this.prefix, this.enabled});
  final String text;
  final bool? obscureText;
  final bool? enabled;
  final Widget? prefix;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextField(
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
          filled: true,
          enabled: enabled ?? true,
          fillColor: AppColors.athensGray,
          hintText: text,
          prefixIcon: prefix,
          suffixIcon: suffix,
          border: OutlineInputBorder(
            borderRadius: context.lowBorderRadius,
          ),
          contentPadding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
        ),
      ),
    );
  }
}
