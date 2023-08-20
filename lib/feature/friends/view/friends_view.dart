import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:sneepy/feature/friends/details/view/friend_details_view.dart';
import 'package:sneepy/feature/friends/viewmodel/friends_viewmodel.dart';
import 'package:sneepy/product/constants/colors.dart';
import 'package:sneepy/product/constants/enums/number.dart';
import 'package:sneepy/product/constants/strings.dart';
import 'package:sneepy/product/init/language/locale_keys.g.dart';
import 'package:sneepy/product/models/user_model.dart';
import 'package:sneepy/product/widgets/button/standart_circle_button.dart';
import 'package:sneepy/product/widgets/button/standart_text_button.dart';
import 'package:sneepy/product/widgets/text/title_large_text.dart';
import 'package:sneepy/product/widgets/text/title_medium_text.dart';
import 'package:url_launcher/url_launcher.dart';

class FriendsView extends StatefulWidget {
  const FriendsView({super.key});

  @override
  State<FriendsView> createState() => _FriendsViewState();
}

class _FriendsViewState extends State<FriendsView> {
  final FriendsViewModel vm = FriendsViewModel();

  @override
  void initState() {
    super.initState();
    getUser();
  }

  Future<void> getUser() async {
    await vm.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Observer(
        builder: (_) {
          return vm.isLoading
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                  onRefresh: getUser,
                  child: vm.user?.friendRequests.isNullOrEmpty == true
                      ? Center(
                          child: TitleLargeText(
                            text: LocaleKeys
                                .friendRequest_thereAreNoFriendRequests
                                .tr(),
                          ),
                        )
                      : ListView.builder(
                          itemCount: vm.user?.friendRequests?.length ??
                              NumberEnum.zero.value.toInt(),
                          itemBuilder: (BuildContext context, int index) {
                            final currentUser = vm.user?.friendRequests?[index];
                            return ListTile(
                              tileColor:
                                  /* currentUser?.sentType == NumberEnum.two.value
                                      ? AppColors.blueRibbon
                                      :  */
                                  index % NumberEnum.two.value ==
                                          NumberEnum.one.value
                                      ? AppColors.background
                                      : AppColors.white,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: context.verticalPaddingLow.vertical,
                                horizontal:
                                    context.horizontalPaddingLow.horizontal,
                              ),
                              leading: CircleAvatar(
                                backgroundImage: CachedNetworkImageProvider(
                                  currentUser?.photos?.firstOrNull?.photo ??
                                      AppStrings.userNotPhoto,
                                ),
                                radius: NumberEnum.fortyEight.value,
                              ),
                              title: Padding(
                                padding: context.onlyBottomPaddingLow,
                                child: TitleMediumText(
                                  text: currentUser?.name ?? AppStrings.empty,
                                ),
                              ),
                              subtitle:
                                  currentUser?.sentType == NumberEnum.one.value
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
                          },
                        ),
                );
        },
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

  AppBar _appBar() {
    return AppBar(
      title: Text(
        LocaleKeys.friendRequest_friendRequests.tr(),
      ),
    );
  }
}

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
          child: deleteButton(),
        ),
        context.emptySizedWidthBoxNormal,
        Expanded(
          child: acceptButton(),
        ),
      ],
    );
  }

  SizedBox deleteButton() {
    return SizedBox(
      height: NumberEnum.forty.value,
      child: StandartTextButton(
        text: LocaleKeys.buttons_delete.tr(),
        backgroundColor: AppColors.persimmon,
        onPressed: () async {
          await vm.deleteFriendRequest(
            userId: currentUser?.id ?? AppStrings.empty,
          );
        },
      ),
    );
  }

  SizedBox acceptButton() {
    return SizedBox(
      height: NumberEnum.forty.value,
      child: StandartTextButton(
        text: LocaleKeys.buttons_accept.tr(),
        backgroundColor: AppColors.caribbeanGreen,
        onPressed: () async {
          await vm.acceptFriendRequest(
            userId: currentUser?.id ?? AppStrings.empty,
          );
        },
      ),
    );
  }
}

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
          child: snapchatButton(),
        ),
        context.emptySizedWidthBoxNormal,
        Expanded(
          child: instagramButton(),
        ),
        context.emptySizedWidthBoxNormal,
        Expanded(
          child: twitterButton(),
        ),
      ],
    );
  }

  SizedBox snapchatButton() {
    return SizedBox(
      height: NumberEnum.forty.value,
      child: StandartCircleButton(
        backgroundColor: AppColors.caribbeanGreen,
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
        child: const Icon(
          FontAwesomeIcons.snapchat,
          color: AppColors.white,
        ),
      ),
    );
  }

  SizedBox instagramButton() {
    return SizedBox(
      height: NumberEnum.forty.value,
      child: StandartCircleButton(
        backgroundColor: AppColors.caribbeanGreen,
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
        child: const Icon(
          FontAwesomeIcons.instagram,
          color: AppColors.white,
        ),
      ),
    );
  }

  SizedBox twitterButton() {
    return SizedBox(
      height: NumberEnum.forty.value,
      child: StandartCircleButton(
        backgroundColor: AppColors.caribbeanGreen,
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
        child: const Icon(
          FontAwesomeIcons.twitter,
          color: AppColors.white,
        ),
      ),
    );
  }
}
