part of "../friends_view.dart";

class SocialAccountsWidget extends StatelessWidget {
  const SocialAccountsWidget({
    super.key,
    required this.currentUser,
  });

  final FriendRequests? currentUser;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: snapchatButton(context),
        ),
        context.emptySizedWidthBoxNormal,
        Expanded(
          child: instagramButton(context),
        ),
        context.emptySizedWidthBoxNormal,
        Expanded(
          child: twitterButton(context),
        ),
      ],
    );
  }

  SizedBox snapchatButton(BuildContext context) {
    return SizedBox(
      height: NumberEnum.forty.value,
      child: StandartCircleButton(
        backgroundColor: currentUser?.snapchat.isNotNullOrNoEmpty == true
            ? context.colorScheme.secondary
            : context.colorScheme.background,
        onPressed: () {
          if (currentUser?.snapchat?.isNotNullOrNoEmpty == true) {
            launchUrl(
              Uri.parse('${AppStrings.snapchat}${currentUser?.snapchat}'),
              mode: LaunchMode.externalApplication,
            );
          } else {
            Fluttertoast.showToast(
              msg: LocaleKeys.friendRequest_usersSnapchatAccountNotFound.tr(),
            );
          }
        },
        child: Icon(FontAwesomeIcons.snapchat,
            color: context.colorScheme.onPrimary),
      ),
    );
  }

  SizedBox instagramButton(BuildContext context) {
    return SizedBox(
      height: NumberEnum.forty.value,
      child: StandartCircleButton(
        backgroundColor: currentUser?.instagram.isNotNullOrNoEmpty == true
            ? context.colorScheme.secondary
            : context.colorScheme.background,
        onPressed: () {
          if (currentUser?.instagram?.isNotNullOrNoEmpty == true) {
            launchUrl(
              Uri.parse('${AppStrings.instagram}${currentUser?.instagram}'),
              mode: LaunchMode.externalApplication,
            );
          } else {
            Fluttertoast.showToast(
              msg: LocaleKeys.friendRequest_usersInstagramAccountNotFound.tr(),
            );
          }
        },
        child: Icon(FontAwesomeIcons.instagram,
            color: context.colorScheme.onPrimary),
      ),
    );
  }

  SizedBox twitterButton(BuildContext context) {
    return SizedBox(
      height: NumberEnum.forty.value,
      child: StandartCircleButton(
        backgroundColor: currentUser?.twitter.isNotNullOrNoEmpty == true
            ? context.colorScheme.secondary
            : context.colorScheme.background,
        onPressed: () {
          if (currentUser?.twitter?.isNotNullOrNoEmpty == true) {
            launchUrl(
              Uri.parse('${AppStrings.twitter}${currentUser?.twitter}'),
              mode: LaunchMode.externalApplication,
            );
          } else {
            Fluttertoast.showToast(
              msg: LocaleKeys.friendRequest_usersTwitterAccountNotFound.tr(),
            );
          }
        },
        child: Icon(FontAwesomeIcons.twitter,
            color: context.colorScheme.onPrimary),
      ),
    );
  }
}
