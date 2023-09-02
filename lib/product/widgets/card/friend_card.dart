import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';
import 'package:sneepy/product/constants/enums/number.dart';
import 'package:sneepy/product/constants/strings.dart';
import 'package:sneepy/product/init/language/locale_keys.g.dart';
import 'package:sneepy/product/models/user_model.dart';
import 'package:sneepy/product/widgets/text/headline_medium_text.dart';
import 'package:sneepy/product/widgets/text/title_large_text.dart';

import '../../../feature/home/viewmodel/home_viewmodel.dart';
import '../text/headline_small_text.dart';

class FriendCard extends StatelessWidget {
  FriendCard({super.key, required this.user});
  final UserModel user;

  final PageController _swipeCardPageController = PageController();

  final _vm = HomeViewModel();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.colorScheme.background,
      shape: RoundedRectangleBorder(
        borderRadius: context.normalBorderRadius,
      ),
      child: ClipRRect(
        borderRadius: context.normalBorderRadius,
        child: Stack(
          children: [
            PageView.builder(
              controller: _swipeCardPageController,
              itemCount: user.photos?.length,
              physics: const NeverScrollableScrollPhysics(),
              allowImplicitScrolling: true,
              itemBuilder: (context, index) {
                final currentUser = user.photos?[index];
                return SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: GestureDetector(
                      onHorizontalDragEnd: (DragEndDetails details) {
                        onHorizontalDragChangePhoto(details, context);
                      },
                      onTapUp: (details) {
                        onTapUpChangePhoto(details, context);
                      },
                      child: UserPhoto(currentUser: currentUser)),
                );
              },
              onPageChanged: (index) {
                pageChangedAndProgressValueUpdated(index);
              },
            ),
            user.photos?.length == NumberEnum.one.value ||
                    user.photos?.length == NumberEnum.zero.value
                ? const SizedBox.shrink()
                : Padding(
                    padding: context.paddingNormal,
                    child: Observer(builder: (_) {
                      return LinearProgressIndicator(
                        value: _vm.progressValue,
                        backgroundColor: Colors.black54,
                        color: context.colorScheme.background,
                      );
                    }),
                  ),
            !user.photos.isNullOrEmpty
                ? Positioned(
                    bottom: NumberEnum.zero.value,
                    child: IgnorePointer(
                      ignoring: false,
                      child: UserInfoContainer(user: user),
                    ),
                  )
                : Center(
                    child: TitleLargeText(
                      text: LocaleKeys.home_usersPhotoCouldNotBeUploaded.tr(),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  void pageChangedAndProgressValueUpdated(int index) {
    _vm.progressValue = (index + NumberEnum.one.value) /
        (user.photos?.length == NumberEnum.two.value
            ? NumberEnum.two.value
            : NumberEnum.three.value);
  }

  void onHorizontalDragChangePhoto(
      DragEndDetails details, BuildContext context) {
    if (details.primaryVelocity! > NumberEnum.one.value) {
      _swipeCardPageController.previousPage(
        duration: context.durationLow,
        curve: Curves.easeInOut,
      );
    } else if (details.primaryVelocity! < NumberEnum.one.value) {
      _swipeCardPageController.nextPage(
        duration: context.durationLow,
        curve: Curves.easeInOut,
      );
    }
  }

  void onTapUpChangePhoto(TapUpDetails details, BuildContext context) {
    if (details.localPosition.direction > NumberEnum.one.value) {
      _swipeCardPageController.previousPage(
        duration: context.durationLow,
        curve: Curves.easeInOut,
      );
    } else if (details.localPosition.direction < NumberEnum.one.value) {
      _swipeCardPageController.nextPage(
        duration: context.durationLow,
        curve: Curves.easeInOut,
      );
    }
  }
}

class UserPhoto extends StatelessWidget {
  const UserPhoto({
    super.key,
    required this.currentUser,
  });

  final Photos? currentUser;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: currentUser?.photo ?? AppStrings.empty,
      placeholder: (context, url) => const Center(
        child: CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) => Icon(
        Icons.error,
        size: NumberEnum.sixty.value,
      ),
      fit: BoxFit.cover,
    );
  }
}

class UserInfoContainer extends StatelessWidget {
  const UserInfoContainer({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      height: NumberEnum.oneHundredTwentyFive.value,
      padding: context.paddingNormal,
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
        color: context.colorScheme.error,
        gradient: const LinearGradient(
          colors: [
            Colors.black,
            Colors.transparent,
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: userNameAndAgeColumn(context),
    );
  }

  Column userNameAndAgeColumn(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeadlineMediumText(
            text: user.name ?? AppStrings.empty,
            color: context.colorScheme.background),
        HeadlineSmallText(
            text: user.age.toString(), color: context.colorScheme.background),
      ],
    );
  }
}
