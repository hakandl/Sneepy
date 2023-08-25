import 'package:flutter/material.dart';

class SelectCard extends StatelessWidget {
  const SelectCard({
    super.key,
    required this.title,
    this.leading,
    this.trailing,
    this.onTap,
    this.subtitle,
  });
  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title: title,
      subtitle: subtitle,
      trailing: trailing ?? const Icon(Icons.arrow_forward_outlined),
      onTap: onTap,
    );
  }
}
