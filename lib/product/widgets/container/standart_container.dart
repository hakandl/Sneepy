import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class StandartContainer extends StatelessWidget {
  const StandartContainer({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.paddingNormal,
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.colorScheme.onPrimary,
        borderRadius: context.normalBorderRadius,
      ),
      child: child,
    );
  }
}
