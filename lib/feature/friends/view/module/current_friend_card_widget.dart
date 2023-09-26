part of "../friends_view.dart";

class CurrentFriendCard extends StatelessWidget {
  const CurrentFriendCard(
      {super.key,
      required this.tileColor,
      required this.currentUser,
      required this.vm});
  final Color tileColor;
  final FriendRequests currentUser;
  final FriendsViewModel vm;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: tileColor,
      contentPadding: EdgeInsets.symmetric(
        vertical: context.verticalPaddingLow.vertical,
        horizontal: context.horizontalPaddingLow.horizontal,
      ),
      leading: userPhoto(),
      title: userNameText(context),
      subtitle: currentUser.sentType == NumberEnum.one.value ||
              currentUser.sentType == NumberEnum.three.value
          ? UserAcceptOrDeleteWidget(
              vm: vm,
              currentUser: currentUser,
            )
          : SocialAccountsWidget(
              currentUser: currentUser,
            ),
      onTap: () {
        goToFriendDetailsView(context, currentUser);
      },
    );
  }

  CircleAvatar userPhoto() {
    return CircleAvatar(
      backgroundImage: CachedNetworkImageProvider(
        currentUser.photos?.firstOrNull?.photo ?? AppStrings.userNotPhoto,
      ),
      radius: NumberEnum.fortyEight.value,
    );
  }

  Padding userNameText(BuildContext context) {
    return Padding(
      padding: context.onlyBottomPaddingLow,
      child: TitleMediumText(
        text: currentUser.name ?? AppStrings.empty,
      ),
    );
  }

  Future<Object?> goToFriendDetailsView(
      BuildContext context, FriendRequests? currentUser) {
    return context.navigateToPage(
      FriendDetailsView(
        id: currentUser?.id ?? AppStrings.empty,
      ),
    );
  }
}
