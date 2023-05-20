import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:sneepy/feature/friends/view/friends_view.dart';
import 'package:sneepy/product/constant/colors.dart';
import 'package:sneepy/product/widgets/button/standart_circle_button.dart';
import 'package:sneepy/product/widgets/card/friend_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.filter_list_rounded)),
        title: const CircleAvatar(
          backgroundImage: NetworkImage(
              'https://media.gettyimages.com/id/1347431090/photo/fit-woman-standing-outdoors-after-a-late-afternoon-trail-run.jpg?s=612x612&w=gi&k=20&c=H9W6QxJoLP607i_BE7kT-VtxNGtaT7E6U4XIn03IHLg='),
          radius: 24,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.group_outlined),
            onPressed: () {
              context.navigateToPage(const FriendsView());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          context.emptySizedHeightBoxLow,
          Expanded(
            child: PageView.builder(
              itemCount: 10,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: context.horizontalPaddingLow,
                  child: FriendCard(),
                );
              },
            ),
          ),
          context.emptySizedHeightBoxLow,
          Row(
            children: [
              Expanded(
                child: StandartCircleButton(
                  backgroundColor: AppColors.persimmon,
                  onPressed: () {},
                  child: const Icon(
                    Icons.cancel_outlined,
                    size: 35,
                    color: AppColors.white,
                  ),
                ),
              ),
              Expanded(
                child: StandartCircleButton(
                  backgroundColor: AppColors.caribbeanGreen,
                  onPressed: () {},
                  child: const Icon(
                    Icons.verified_outlined,
                    size: 35,
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
