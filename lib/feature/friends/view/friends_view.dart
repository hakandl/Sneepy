import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:sneepy/feature/friends/details/view/friend_details_view.dart';
import 'package:sneepy/product/constant/colors.dart';
import 'package:sneepy/product/widgets/button/standart_text_button.dart';
import 'package:sneepy/product/widgets/text/title_medium_text.dart';

class FriendsView extends StatelessWidget {
  const FriendsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Arkadaşlık İstekleri'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            tileColor: index % 2 == 1 ? AppColors.background : AppColors.white,
            contentPadding: EdgeInsets.symmetric(
              vertical: context.verticalPaddingLow.vertical,
              horizontal: context.horizontalPaddingLow.horizontal,
            ),
            leading: const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://media.gettyimages.com/id/1347431090/photo/fit-woman-standing-outdoors-after-a-late-afternoon-trail-run.jpg?s=612x612&w=gi&k=20&c=H9W6QxJoLP607i_BE7kT-VtxNGtaT7E6U4XIn03IHLg='),
              radius: 48,
            ),
            title: Padding(
              padding: context.onlyBottomPaddingLow,
              child: const TitleMediumText(text: 'text'),
            ),
            subtitle: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: StandartTextButton(
                      text: 'text',
                      backgroundColor: AppColors.persimmon,
                      onPressed: () {},
                    ),
                  ),
                ),
                context.emptySizedWidthBoxNormal,
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: StandartTextButton(
                      text: 'text',
                      backgroundColor: AppColors.caribbeanGreen,
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
            onTap: () {
              context.navigateToPage(const FriendDetailsView());
            },
          );
        },
      ),
    );
  }
}
