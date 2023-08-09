import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';
import 'package:sneepy/feature/friends/details/view/friend_details_view.dart';
import 'package:sneepy/feature/friends/viewmodel/friends_viewmodel.dart';
import 'package:sneepy/product/constants/colors.dart';
import 'package:sneepy/product/constants/enums/number.dart';
import 'package:sneepy/product/constants/strings.dart';
import 'package:sneepy/product/init/language/locale_keys.g.dart';
import 'package:sneepy/product/models/user_model.dart';
import 'package:sneepy/product/widgets/button/standart_text_button.dart';
import 'package:sneepy/product/widgets/text/title_large_text.dart';
import 'package:sneepy/product/widgets/text/title_medium_text.dart';

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
                              tileColor: index % NumberEnum.two.value ==
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
                                      AppStrings.empty,
                                ),
                                radius: NumberEnum.fortyEight.value,
                              ),
                              title: Padding(
                                padding: context.onlyBottomPaddingLow,
                                child: TitleMediumText(
                                  text: currentUser?.name ?? AppStrings.empty,
                                ),
                              ),
                              subtitle: Row(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: NumberEnum.forty.value,
                                      child: StandartTextButton(
                                        text: LocaleKeys.buttons_delete.tr(),
                                        backgroundColor: AppColors.persimmon,
                                        onPressed: () {},
                                      ),
                                    ),
                                  ),
                                  context.emptySizedWidthBoxNormal,
                                  Expanded(
                                    child: SizedBox(
                                      height: NumberEnum.forty.value,
                                      child: StandartTextButton(
                                        text: LocaleKeys.buttons_accept.tr(),
                                        backgroundColor:
                                            AppColors.caribbeanGreen,
                                        onPressed: () {},
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {
                                context.navigateToPage(
                                  FriendDetailsView(
                                    user: vm.user ?? UserModel(),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                );
        },
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
