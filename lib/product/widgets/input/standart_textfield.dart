import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class StandartTextField extends StatefulWidget {
  const StandartTextField({super.key, required this.text, this.obscureText});
  final String text;
  final bool? obscureText;

  @override
  State<StandartTextField> createState() => _StandartTextFieldState();
}

class _StandartTextFieldState extends State<StandartTextField> {
  final focus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextField(
        focusNode: focus,
        textAlignVertical: TextAlignVertical.bottom,
        obscureText: widget.obscureText ?? false,
        decoration: InputDecoration(
          hintText: focus.hasFocus ? widget.text : '',
          labelText: widget.text,
          border: OutlineInputBorder(
            borderRadius: context.lowBorderRadius,
          ),
        ),
      ),
    );
  }
}
