import 'package:flutter/material.dart';

class SelectCard extends StatelessWidget {
  const SelectCard(
      {super.key,
      required this.title,
      required this.leading,
      required this.trailing});
  final Widget title;
  final Widget leading;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title: title,
      trailing: trailing,
    );
  }
}
