import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:sneepy/feature/friends/details/view/friend_details_view.dart';
import 'package:sneepy/feature/friends/viewmodel/friends_viewmodel.dart';
import 'package:sneepy/product/constants/enums/number.dart';
import 'package:sneepy/product/constants/strings.dart';
import 'package:sneepy/product/init/language/locale_keys.g.dart';
import 'package:sneepy/product/models/user_model.dart';
import 'package:sneepy/product/widgets/button/standart_circle_button.dart';
import 'package:sneepy/product/widgets/button/standart_text_button.dart';
import 'package:sneepy/product/widgets/text/title_large_text.dart';
import 'package:sneepy/product/widgets/text/title_medium_text.dart';
import 'package:url_launcher/url_launcher.dart';

part 'module/social_accounts_widget.dart';
part 'module/user_accept_or_delete_widget.dart';
part 'module/current_friend_card_widget.dart';

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
          return vm.loading.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
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
                            Color? tileColor;
                            if (currentUser?.sentType ==
                                NumberEnum.three.value) {
                              tileColor = context.colorScheme.onError;
                            } else if (index % NumberEnum.two.value ==
                                NumberEnum.one.value) {
                              tileColor = context.colorScheme.onBackground;
                            } else {
                              tileColor = context.colorScheme.onPrimary;
                            }
                            return CurrentFriendCard(
                              tileColor: tileColor,
                              currentUser: currentUser ?? FriendRequests(),
                              vm: vm,
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
