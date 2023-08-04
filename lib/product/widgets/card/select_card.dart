import 'package:flutter/material.dart';

class SelectCard extends StatelessWidget {
  const SelectCard({
    super.key,
    required this.title,
    this.leading,
    this.trailing,
    this.onTap,
  });
  final Widget title;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title: title,
      trailing: trailing,
      onTap: onTap,
    );
  }
}
