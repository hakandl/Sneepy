import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:sneepy/feature/home/view/home_view.dart';
import 'package:sneepy/feature/profie/settings/view/profile_settings_view.dart';
import 'package:sneepy/feature/profie/settings/viewmodel/settings_viewmodel.dart';
import 'package:sneepy/product/constants/enums/number.dart';
import 'package:sneepy/product/constants/service.dart';
import 'package:sneepy/product/constants/strings.dart';
import 'package:sneepy/product/init/language/locale_keys.g.dart';
import 'package:sneepy/product/widgets/container/standart_container.dart';
import 'package:sneepy/product/widgets/input/standart_textfield.dart';
import 'package:sneepy/product/widgets/text/headline_medium_text.dart';
import 'package:sneepy/product/widgets/text/title_large_text.dart';
import 'package:sneepy/product/widgets/text/title_medium_text.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({
    super.key,
  });

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
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
    return WillPopScope(
      onWillPop: () async {
        context.navigateToPage(
          const HomeView(),
        );
        return false;
      },
      child: Scaffold(
        appBar: _appBar(context),
        body: Observer(
          builder: (_) {
            return _vm.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      context.emptySizedHeightBoxLow3x,
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              UserPhotoAndNameContainer(vm: _vm),
                              context.emptySizedHeightBoxNormal,
                              SomeInformationContainer(vm: _vm),
                              context.emptySizedHeightBoxNormal,
                              SocialAccountsContainer(vm: _vm),
                            ],
                          ),
                        ),
                      ),
                      context.emptySizedHeightBoxLow3x,
                    ],
                  );
          },
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: Text(
        LocaleKeys.profile_profile.tr(),
      ),
      leading: BackButton(
        onPressed: () {
          context.navigateToPage(
            const HomeView(),
          );
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings_outlined),
          onPressed: () {
            context.navigateToPage(
              const ProfileSettingsView(),
            );
          },
        ),
      ],
    );
  }
}

class UserPhotoAndNameContainer extends StatelessWidget {
  const UserPhotoAndNameContainer({
    super.key,
    required SettingsViewModel vm,
  }) : _vm = vm;

  final SettingsViewModel _vm;

  @override
  Widget build(BuildContext context) {
    return StandartContainer(
      child: Row(
        children: [
          CircleAvatar(
            radius: NumberEnum.fortyEight.value,
            backgroundImage: CachedNetworkImageProvider(
              _vm.me?.photos?.firstOrNull?.photo ?? AppStrings.userNotPhoto,
            ),
          ),
          context.emptySizedWidthBoxNormal,
          Expanded(
            child: HeadlineMediumText(
              text: _vm.me?.name ?? AppStrings.empty,
            ),
          ),
        ],
      ),
    );
  }
}

class SomeInformationContainer extends StatelessWidget {
  const SomeInformationContainer({
    super.key,
    required this.vm,
  });
  final SettingsViewModel vm;

  @override
  Widget build(BuildContext context) {
    return StandartContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleLargeText(
            text: LocaleKeys.profile_someInformation.tr(),
          ),
          context.emptySizedHeightBoxLow3x,
          TitleMediumText(
            text: LocaleKeys.auth_register_age.tr(),
          ),
          context.emptySizedHeightBoxLow,
          StandartTextField(
            text: vm.me?.age.toString(),
            prefix: const Icon(
              FontAwesomeIcons.arrowUp19,
            ),
            enabled: false,
          ),
          context.emptySizedHeightBoxLow3x,
          TitleMediumText(
            text: LocaleKeys.auth_register_gender.tr(),
          ),
          context.emptySizedHeightBoxLow,
          StandartTextField(
            text: vm.me?.gender == ServiceConstants.female
                ? LocaleKeys.auth_register_woman.tr()
                : LocaleKeys.auth_register_man.tr(),
            prefix: const Icon(
              FontAwesomeIcons.marsAndVenus,
            ),
            enabled: false,
          ),
          context.emptySizedHeightBoxLow3x,
          TitleMediumText(
            text: LocaleKeys.auth_email.tr(),
          ),
          context.emptySizedHeightBoxLow,
          StandartTextField(
            text: vm.me?.email ?? AppStrings.empty,
            prefix: const Icon(
              FontAwesomeIcons.envelope,
            ),
            enabled: false,
          ),
        ],
      ),
    );
  }
}

class SocialAccountsContainer extends StatelessWidget {
  const SocialAccountsContainer({
    super.key,
    required this.vm,
  });

  final SettingsViewModel vm;

  @override
  Widget build(BuildContext context) {
    return StandartContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleLargeText(
            text: LocaleKeys.profile_socialAccounts.tr(),
          ),
          context.emptySizedHeightBoxLow3x,
          TitleMediumText(
            text: LocaleKeys.auth_register_snapchat.tr(),
          ),
          context.emptySizedHeightBoxLow,
          StandartTextField(
            text: vm.me?.snapchat ?? AppStrings.empty,
            prefix: const Icon(
              FontAwesomeIcons.snapchat,
            ),
            enabled: false,
          ),
          context.emptySizedHeightBoxLow3x,
          TitleMediumText(
            text: LocaleKeys.auth_register_instagram.tr(),
          ),
          context.emptySizedHeightBoxLow,
          StandartTextField(
            text: vm.me?.instagram ?? AppStrings.empty,
            prefix: const Icon(
              FontAwesomeIcons.instagram,
            ),
            enabled: false,
          ),
          context.emptySizedHeightBoxLow3x,
          TitleMediumText(
            text: LocaleKeys.auth_register_twitter.tr(),
          ),
          context.emptySizedHeightBoxLow,
          StandartTextField(
            text: vm.me?.twitter ?? AppStrings.empty,
            prefix: const Icon(
              FontAwesomeIcons.twitter,
            ),
            enabled: false,
          ),
        ],
      ),
    );
  }
}
