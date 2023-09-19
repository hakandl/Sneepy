part of '../home_view.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    super.key,
    required HomeViewModel vm,
    required this.pageController,
    required this.userCard,
  }) : _vm = vm;

  final HomeViewModel _vm;
  final PageController pageController;
  final GlobalKey userCard;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: _vm.users.length,
      controller: pageController,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        _vm.currentUser = _vm.users[index];
        return Padding(
          padding: context.horizontalPaddingLow,
          child: Showcase(
            key: userCard,
            description: LocaleKeys
                .home_youCanSeeOtherPhotosIfAvailableBySwipingRightAndLeftOrClickingOnThem
                .tr(),
            targetBorderRadius: context.normalBorderRadius,
            targetPadding: context.paddingLow,
            child: FriendCard(
              user: _vm.currentUser ?? UserModel(),
            ),
          ),
        );
      },
    );
  }
}
