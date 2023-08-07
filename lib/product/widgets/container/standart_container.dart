import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../constants/colors.dart';

class StandartContainer extends StatelessWidget {
  const StandartContainer({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.paddingNormal,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: context.normalBorderRadius,
      ),
      child: child,
    );
  }
}
