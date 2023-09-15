import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:sneepy/feature/friends/view/friends_view.dart';
import 'package:sneepy/feature/home/viewmodel/home_viewmodel.dart';
import 'package:sneepy/feature/profie/view/profile_view.dart';
import 'package:sneepy/feature/rewards/view/rewards_view.dart';
import 'package:sneepy/product/constants/enums/number.dart';
import 'package:sneepy/product/constants/strings.dart';
import 'package:sneepy/product/init/language/locale_keys.g.dart';
import 'package:sneepy/product/models/user_model.dart';
import 'package:sneepy/product/widgets/button/standart_circle_button.dart';
import 'package:sneepy/product/widgets/card/friend_card.dart';
import 'package:sneepy/product/widgets/dialog/standart_dialog.dart';
import 'package:sneepy/product/widgets/text/title_large_text.dart';
import 'package:sneepy/product/widgets/text/title_medium_text.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _vm = HomeViewModel();
  final PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _vm.firstShowCase(context);
    });
    getData();
  }

  Future<void> getData() async {
    await _vm.getUsers();
    await _vm.getMe();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Column(
        children: [
          context.emptySizedHeightBoxLow,
          Observer(builder: (_) {
            return Expanded(
              child: _vm.loading.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _vm.users.isNullOrEmpty
                      ? const NoUsersFound()
                      : UserCard(
                          vm: _vm,
                          pageController: pageController,
                          userCard: _vm.userCardKey,
                        ),
            );
          }),
          context.emptySizedHeightBoxLow,
          Observer(builder: (_) {
            return _vm.loading.isLoading
                ? const SizedBox.shrink()
                : BottomButtons(
                    vm: _vm,
                    pageController: pageController,
                    skipFriendRequest: _vm.skipFriendRequestKey,
                    sendFriendRequest: _vm.sendFriendRequestKey,
                  );
          }),
          context.emptySizedHeightBoxLow,
        ],
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: NumberEnum.zero.value,
        title: Observer(
          builder: (_) {
            return _vm.loading.isLoading
                ? CircularProgressIndicator(
                    color: context.colorScheme.onPrimary,
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: context.onlyLeftPaddingNormal,
                        child: _vm.loading.isLoading
                            ? const SizedBox.shrink()
                            : Showcase(
                                key: _vm.profileKey,
                                description: LocaleKeys
                                    .home_youCanReachYourProfileHere
                                    .tr(),
                                targetShapeBorder: const CircleBorder(),
                                targetPadding: context.paddingLow,
                                child: CircleAvatar(
                                  backgroundImage: CachedNetworkImageProvider(
                                    _vm.me?.photos?.firstOrNull?.photo ??
                                        AppStrings.userNotPhoto,
                                  ),
                                  child: InkWell(
                                    borderRadius: context.normalBorderRadius,
                                    onTap: () {
                                      context.navigateToPage(
                                        const ProfileView(),
                                      );
                                    },
                                  ),
                                ),
                              ),
                      ),
                      Showcase(
                        key: _vm.pointKey,
                        description:
                            LocaleKeys.home_clickHereNowToEarnMorePoints.tr(),
                        targetBorderRadius: context.highBorderRadius,
                        targetPadding: context.verticalPaddingLow,
                        child: InkWell(
                          borderRadius: context.normalBorderRadius,
                          child: Stack(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                padding: context.paddingLow,
                                margin: context.horizontalPaddingLow,
                                decoration: BoxDecoration(
                                  color: context.colorScheme.background,
                                  borderRadius: context.normalBorderRadius,
                                ),
                                width:
                                    context.dynamicWidth(NumberEnum.zTwo.value),
                                child: TitleMediumText(
                                  text: _vm.me?.point.toString() ??
                                      AppStrings.empty,
                                ),
                              ),
                              _vm.me?.isFreePoint == true
                                  ? Positioned(
                                      top: NumberEnum.zero.value,
                                      right: NumberEnum.zero.value,
                                      child: CircleAvatar(
                                        radius: NumberEnum.ten.value,
                                        backgroundColor:
                                            context.colorScheme.secondary,
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ],
                          ),
                          onTap: () =>
                              context.navigateToPage(const RewardsView()),
                        ),
                      ),
                      IconButton(
                        icon: Showcase(
                          key: _vm.friendRequestKey,
                          description: LocaleKeys
                              .home_youCanSeeYourFriendRequestsHere
                              .tr(),
                          targetShapeBorder: const CircleBorder(),
                          targetPadding: context.paddingLow,
                          child: const Icon(Icons.group_outlined),
                        ),
                        onPressed: () {
                          context.navigateToPage(
                            const FriendsView(),
                          );
                        },
                      ),
                    ],
                  );
          },
        ));
  }
}

class NoUsersFound extends StatelessWidget {
  const NoUsersFound({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TitleLargeText(text: LocaleKeys.home_noUsersFound.tr()),
    );
  }
}

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

class BottomButtons extends StatelessWidget {
  const BottomButtons({
    super.key,
    required HomeViewModel vm,
    required this.pageController,
    required this.skipFriendRequest,
    required this.sendFriendRequest,
  }) : _vm = vm;

  final HomeViewModel _vm;
  final PageController pageController;
  final GlobalKey skipFriendRequest;
  final GlobalKey sendFriendRequest;

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
            backgroundColor: context.colorScheme.secondary,
            onPressed: () async {
              final response = await _vm.sendFriendRequest(
                userId: _vm.currentUser?.id ?? AppStrings.empty,
                sentType: 1,
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
