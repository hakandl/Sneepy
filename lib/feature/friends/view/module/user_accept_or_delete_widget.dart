part of "../friends_view.dart";

class UserAcceptOrDeleteWidget extends StatelessWidget {
  const UserAcceptOrDeleteWidget({
    super.key,
    required this.vm,
    required this.currentUser,
  });

  final FriendsViewModel vm;
  final FriendRequests? currentUser;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: deleteButton(context),
        ),
        context.emptySizedWidthBoxNormal,
        Expanded(
          child: acceptButton(context),
        ),
      ],
    );
  }

  SizedBox deleteButton(BuildContext context) {
    return SizedBox(
      height: NumberEnum.forty.value,
      child: StandartTextButton(
        text: LocaleKeys.buttons_delete.tr(),
        backgroundColor: context.colorScheme.error,
        onPressed: () async {
          await vm.deleteFriendRequest(
            userId: currentUser?.id ?? AppStrings.empty,
          );
        },
      ),
    );
  }

  SizedBox acceptButton(BuildContext context) {
    return SizedBox(
      height: NumberEnum.forty.value,
      child: StandartTextButton(
        text: LocaleKeys.buttons_accept.tr(),
        backgroundColor: context.colorScheme.secondary,
        onPressed: () async {
          await vm.acceptFriendRequest(
            userId: currentUser?.id ?? AppStrings.empty,
          );
        },
      ),
    );
  }
}
