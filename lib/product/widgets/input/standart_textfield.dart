import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:sneepy/product/constant/colors.dart';

class StandartTextField extends StatelessWidget {
  StandartTextField(
      {super.key, required this.text, this.obscureText, this.suffix, this.prefix, this.enabled, this.keyboardType});
  final TextEditingController controller = TextEditingController();
  final String text;
  final bool? obscureText;
  final bool? enabled;
  final Widget? prefix;
  final Widget? suffix;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextField(
        controller: controller,
        obscureText: obscureText ?? false,
        keyboardType: keyboardType,
        textInputAction: TextInputAction.next,
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
