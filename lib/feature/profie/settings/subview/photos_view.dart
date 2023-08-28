import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';
import 'package:sneepy/feature/profie/settings/viewmodel/settings_viewmodel.dart';
import 'package:sneepy/product/constants/enums/number.dart';
import 'package:sneepy/product/constants/strings.dart';
import 'package:sneepy/product/init/language/locale_keys.g.dart';
import 'package:sneepy/product/widgets/card/select_card.dart';
import 'package:sneepy/product/widgets/container/standart_container.dart';
import 'package:sneepy/product/widgets/dialog/standart_dialog.dart';
import 'package:sneepy/product/widgets/text/title_medium_text.dart';

class PhotosView extends StatefulWidget {
  const PhotosView({super.key});

  @override
  State<PhotosView> createState() => _PhotosViewState();
}

class _PhotosViewState extends State<PhotosView> {
  final _vm = SettingsViewModel();

  @override
  void initState() {
    super.initState();
    getMe();
  }

  Future<void> getMe() async {
    await _vm.getMe();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(),
        body: Observer(
          builder: (_) {
            return _vm.loading.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      context.emptySizedHeightBoxLow3x,
                      photoGridContainer(),
                      context.emptySizedHeightBoxLow3x,
                    ],
                  );
          },
        ));
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        LocaleKeys.settings_photos.tr(),
      ),
    );
  }

  StandartContainer photoGridContainer() {
    return StandartContainer(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: NumberEnum.three.value.toInt(),
          childAspectRatio: NumberEnum.nine.value / NumberEnum.sixteen.value,
          crossAxisSpacing: NumberEnum.ten.value,
          mainAxisSpacing: NumberEnum.ten.value,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: NumberEnum.three.value.toInt(),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: photoIndexControl(index)
                ? () {
                    updateOrDeletePhotoModalBottomSheet(
                      context,
                      index,
                    );
                  }
                : () async {
                    await addPhoto(context);
                  },
            borderRadius: context.normalBorderRadius,
            child: photoContainer(context, index),
          );
        },
      ),
    );
  }

  Container photoContainer(BuildContext context, int index) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: context.normalBorderRadius,
        color: context.colorScheme.background,
      ),
      child: photoIndexControl(index) ? photo(context, index) : noPhoto(),
    );
  }

  ClipRRect photo(BuildContext context, int index) {
    return ClipRRect(
      borderRadius: context.normalBorderRadius,
      child: CachedNetworkImage(
        imageUrl: _vm.me!.photos![index].photo ?? AppStrings.empty,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => Icon(
          Icons.error,
          size: NumberEnum.sixty.value,
        ),
        fit: BoxFit.cover,
      ),
    );
  }

  Icon noPhoto() {
    return Icon(
      Icons.add_circle_outline,
      size: NumberEnum.seventyTwo.value,
      color: context.colorScheme.primary,
    );
  }

  void updateOrDeletePhotoModalBottomSheet(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: NumberEnum.five.value,
              width: NumberEnum.sixtyFour.value,
              margin: context.verticalPaddingNormal,
              decoration: BoxDecoration(
                color: context.colorScheme.background,
                borderRadius: context.highBorderRadius,
              ),
            ),
            SelectCard(
              title: TitleMediumText(
                text: LocaleKeys.buttons_update.tr(),
              ),
              onTap: () async {
                await updatePhoto(
                  index,
                  context,
                );
              },
            ),
            SelectCard(
              title: TitleMediumText(
                text: LocaleKeys.buttons_delete.tr(),
              ),
              onTap: () async {
                await deletePhoto(
                  index,
                  context,
                );
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> addPhoto(BuildContext context) async {
    final response = await _vm.selectImageAndAddPhoto();
    if (response.success == false) {
      if (context.mounted) {
        showStandartDialog(
          context,
          title: LocaleKeys.thereIsProblem.tr(),
          content: Text(
            response.message ?? LocaleKeys.thereIsProblem.tr(),
          ),
        );
      }
    }
  }

  Future<void> updatePhoto(int index, BuildContext context) async {
    final response = await _vm.updatePhoto(
      photoId: _vm.me?.photos?[index].id ?? AppStrings.empty,
    );
    if (response.success == false) {
      if (context.mounted) {
        showStandartDialog(
          context,
          title: LocaleKeys.thereIsProblem.tr(),
          content: Text(
            response.message ?? LocaleKeys.thereIsProblem.tr(),
          ),
        );
      }
    }
  }

  Future<void> deletePhoto(int index, BuildContext context) async {
    final response = await _vm.deletePhoto(
      photoId: _vm.me?.photos?[index].id ?? AppStrings.empty,
    );
    if (context.mounted) {
      showStandartDialog(
        context,
        title: LocaleKeys.thereIsProblem.tr(),
        content: Text(
          response.message ?? LocaleKeys.thereIsProblem.tr(),
        ),
      );
    }
  }

  bool photoIndexControl(int index) {
    return _vm.me?.photos != null &&
        index >= NumberEnum.zero.value &&
        index < (_vm.me?.photos?.length ?? NumberEnum.zero.value);
  }
}
