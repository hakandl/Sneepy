import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:sneepy/product/constants/colors.dart';

Future<T?> showStandartModalBottomSheet<T>(
  BuildContext context, {
  required final Widget child,
  final double? paddingHorizontal,
  final bool? isDynamicHeight,
  final double? height,
}) async {
  return await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) {
        return isDynamicHeight == true
            ? Wrap(
                children: [
                  const Center(
                    child: _ModalBottomSheetContainerDivider(),
                  ),
                  child,
                ],
              )
            : SizedBox(
                height: height != null
                    ? context.dynamicHeight(height)
                    : context.dynamicHeight(.8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const _ModalBottomSheetContainerDivider(),
                    Expanded(
                      child: Padding(
                        padding: context.paddingNormal,
                        child: child,
                      ),
                    ),
                  ],
                ),
              );
      });
}

class _ModalBottomSheetContainerDivider extends StatelessWidget {
  const _ModalBottomSheetContainerDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.dynamicHeight(.006),
      width: context.dynamicWidth(.15),
      margin: context.verticalPaddingNormal,
      decoration: BoxDecoration(
        color: AppColors.athensGray,
        borderRadius: context.highBorderRadius,
      ),
    );
  }
}
