import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';
import 'package:sneepy/feature/friends/view/friends_view.dart';
import 'package:sneepy/feature/home/viewmodel/home_viewmodel.dart';
import 'package:sneepy/feature/profie/view/profile_view.dart';
import 'package:sneepy/product/constants/colors.dart';
import 'package:sneepy/product/constants/enums/number.dart';
import 'package:sneepy/product/constants/strings.dart';
import 'package:sneepy/product/services/user_service.dart';
import 'package:sneepy/product/widgets/button/standart_circle_button.dart';
import 'package:sneepy/product/widgets/card/friend_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _vm = HomeViewModel();

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    await _vm.getUsers();
    await _vm.getMe();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async {
            await UserService().getUsers();
          },
          icon: const Icon(
            Icons.filter_list_rounded,
          ),
        ),
        title: Observer(
          builder: (_) {
            return _vm.isLoading
                ? const CircularProgressIndicator(
                    color: AppColors.white,
                  )
                : CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(
                      _vm.me.photos?.firstOrNull?.photo ?? AppStrings.empty,
                    ),
                    radius: 24,
                    child: InkWell(
                      borderRadius: context.normalBorderRadius,
                      onTap: () {
                        context.navigateToPage(
                          const ProfileView(),
                        );
                      },
                    ),
                  );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.group_outlined),
            onPressed: () {
              context.navigateToPage(
                const FriendsView(),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          context.emptySizedHeightBoxLow,
          Observer(builder: (_) {
            return Expanded(
              child: _vm.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : PageView.builder(
                      itemCount: _vm.users.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final currentUser = _vm.users[index];
                        return Padding(
                          padding: context.horizontalPaddingLow,
                          child: FriendCard(
                            user: currentUser,
                          ),
                        );
                      },
                    ),
            );
          }),
          context.emptySizedHeightBoxLow,
          Row(
            children: [
              Expanded(
                child: StandartCircleButton(
                  backgroundColor: AppColors.persimmon,
                  onPressed: () {},
                  child: Icon(
                    Icons.cancel_outlined,
                    size: NumberEnum.thirty.value,
                    color: AppColors.white,
                  ),
                ),
              ),
              Expanded(
                child: StandartCircleButton(
                  backgroundColor: AppColors.caribbeanGreen,
                  onPressed: () {},
                  child: Icon(
                    Icons.verified_outlined,
                    size: NumberEnum.thirty.value,
                    color: AppColors.white,
                  ),
                ),
              )
            ],
          ),
          context.emptySizedHeightBoxLow,
        ],
      ),
    );
  }
}
