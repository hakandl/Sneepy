import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';
import 'package:sneepy/product/constant/colors.dart';
import 'package:sneepy/product/widgets/text/headline_medium_text.dart';

import '../../../feature/home/viewmodel/home_viewmodel.dart';
import '../text/headline_small_text.dart';

class FriendCard extends StatelessWidget {
  FriendCard({super.key});

  final PageController _swipeCardPageController = PageController(initialPage: 0);

  final _vm = HomeViewModel();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: context.normalBorderRadius,
      ),
      child: ClipRRect(
        borderRadius: context.normalBorderRadius,
        child: Stack(
          children: [
            PageView.builder(
              controller: _swipeCardPageController,
              itemCount: 3,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                List<String> images = [
                  'https://media.gettyimages.com/id/1347431090/photo/fit-woman-standing-outdoors-after-a-late-afternoon-trail-run.jpg?s=612x612&w=gi&k=20&c=H9W6QxJoLP607i_BE7kT-VtxNGtaT7E6U4XIn03IHLg=',
                  "https://images.pexels.com/photos/733872/pexels-photo-733872.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                  "https://images.unsplash.com/photo-1506795660198-e95c77602129?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8YmVhdXRpZnVsJTIwd29tYW58ZW58MHx8MHx8fDA%3D&w=1000&q=80",
                ];
                return SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: InkWell(
                    onTapUp: (details) {
                      if (details.localPosition.direction > 1.0) {
                        _swipeCardPageController.previousPage(
                            duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                      } else if (details.localPosition.direction < 1.0) {
                        _swipeCardPageController.nextPage(
                            duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                      }
                    },
                    child: Image.network(
                      images[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
              onPageChanged: (index) {
                _vm.progressValue = (index + 1) / 3;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Observer(builder: (_) {
                return LinearProgressIndicator(
                  value: _vm.progressValue,
                  backgroundColor: Colors.black54,
                  color: AppColors.athensGray,
                );
              }),
            ),
            Positioned(
              bottom: 0,
              child: IgnorePointer(
                ignoring: false,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 125,
                  padding: context.paddingNormal,
                  alignment: Alignment.bottomLeft,
                  decoration: const BoxDecoration(
                    color: AppColors.persimmon,
                    gradient: LinearGradient(
                      colors: [
                        Colors.black,
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeadlineMediumText(text: 'text', color: AppColors.athensGray),
                      HeadlineSmallText(text: 'text', color: AppColors.athensGray),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}