import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kartal/kartal.dart';

class StandartTextField extends StatelessWidget {
  StandartTextField(
      {super.key,
      this.text,
      this.obscureText,
      this.suffix,
      this.prefix,
      this.enabled,
      this.keyboardType,
      this.validator,
      this.inputFormatters});
  final TextEditingController controller = TextEditingController();
  final String? text;
  final bool? obscureText;
  final bool? enabled;
  final Widget? prefix;
  final Widget? suffix;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: TextFormField(
        validator: validator,
        controller: controller,
        obscureText: obscureText ?? false,
        keyboardType: keyboardType,
        textInputAction: TextInputAction.next,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          filled: true,
          enabled: enabled ?? true,
          fillColor: context.colorScheme.background,
          hintText: text,
          prefixIcon: prefix,
          suffixIcon: suffix,
          border: OutlineInputBorder(
            borderRadius: context.lowBorderRadius,
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: context.lowBorderRadius,
          ),
          hintStyle: TextStyle(
            color: context.colorScheme.surface,
            fontWeight: FontWeight.w400,
          ),
          contentPadding: context.horizontalPaddingNormal,
        ),
      ),
    );
  }
}
