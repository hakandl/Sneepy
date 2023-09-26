part of '../home_view.dart';

class BottomButtons extends StatelessWidget {
  const BottomButtons({
    super.key,
    required HomeViewModel vm,
    required this.pageController,
    required this.skipFriendRequest,
    required this.sendFriendRequest,
    required this.sendStarFriendRequest,
  }) : _vm = vm;

  final HomeViewModel _vm;
  final PageController pageController;
  final GlobalKey skipFriendRequest;
  final GlobalKey sendFriendRequest;
  final GlobalKey sendStarFriendRequest;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: StandartCircleButton(
            backgroundColor: context.colorScheme.error,
            onPressed: () async {
              final response = await _vm.skipFriendRequest(
                userId: _vm.currentUser?.id ?? AppStrings.empty,
                pageController: pageController,
              );
              if (response.success == false) {
                if (context.mounted) {
                  showStandartDialog(
                    context,
                    title: LocaleKeys.thereIsProblem.tr(),
                    content: Text(
                      response.message ?? AppStrings.empty,
                    ),
                  );
                }
              }
            },
            child: Showcase(
              key: skipFriendRequest,
              description: LocaleKeys.home_youCanUseThisButtonToPassUser.tr(),
              targetShapeBorder: const CircleBorder(),
              targetPadding: context.paddingNormal,
              child: Icon(
                Icons.cancel_outlined,
                size: NumberEnum.thirty.value,
                color: context.colorScheme.onPrimary,
              ),
            ),
          ),
        ),
        Expanded(
          child: StandartCircleButton(
            backgroundColor: context.colorScheme.onError,
            onPressed: () async {
              final response = await _vm.sendFriendRequest(
                userId: _vm.currentUser?.id ?? AppStrings.empty,
                sentType: NumberEnum.three.value.toInt(),
                pageController: pageController,
              );
              if (response.success == false) {
                if (context.mounted) {
                  showStandartDialog(
                    context,
                    title: LocaleKeys.thereIsProblem.tr(),
                    content: Text(
                      response.message ?? AppStrings.empty,
                    ),
                  );
                }
              }
            },
            child: Showcase(
              key: sendStarFriendRequest,
              description:
                  LocaleKeys.home_youCanSendColorRequestToStandOut.tr(),
              targetShapeBorder: const CircleBorder(),
              targetPadding: context.paddingLow,
              child: Icon(
                Icons.star_border_rounded,
                size: NumberEnum.fortyEight.value,
                color: context.colorScheme.onPrimary,
              ),
            ),
          ),
        ),
        Expanded(
          child: StandartCircleButton(
            backgroundColor: context.colorScheme.secondary,
            onPressed: () async {
              final response = await _vm.sendFriendRequest(
                userId: _vm.currentUser?.id ?? AppStrings.empty,
                sentType: NumberEnum.one.value.toInt(),
                pageController: pageController,
              );
              if (response.success == false) {
                if (context.mounted) {
                  showStandartDialog(
                    context,
                    title: LocaleKeys.thereIsProblem.tr(),
                    content: Text(
                      response.message ?? AppStrings.empty,
                    ),
                  );
                }
              }
            },
            child: Showcase(
              key: sendFriendRequest,
              description:
                  LocaleKeys.home_youCanUseThisButtonToSendRequestToUser.tr(),
              targetShapeBorder: const CircleBorder(),
              targetPadding: context.paddingNormal,
              child: Icon(
                Icons.verified_outlined,
                size: NumberEnum.thirty.value,
                color: context.colorScheme.onPrimary,
              ),
            ),
          ),
        )
      ],
    );
  }
}
