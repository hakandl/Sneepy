import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';
import 'package:sneepy/feature/profie/settings/viewmodel/settings_viewmodel.dart';
import 'package:sneepy/product/init/language/locale_keys.g.dart';
import 'package:sneepy/product/models/user_model.dart';
import 'package:sneepy/product/widgets/container/standart_container.dart';
import 'package:sneepy/product/widgets/text/title_medium_text.dart';

import '../../../../product/widgets/button/standart_text_button.dart';

class SocialAccountView extends StatefulWidget {
  const SocialAccountView({super.key});

  @override
  State<SocialAccountView> createState() => _SocialAccountViewState();
}

class _SocialAccountViewState extends State<SocialAccountView> {
  final SettingsViewModel vm = SettingsViewModel();

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    await vm.getMe();
    vm.initSocialAccountsView(vm.me ?? UserModel());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Observer(
        builder: (_) {
          return vm.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    context.emptySizedHeightBoxLow3x,
                    Flexible(
                      child: SocialAccountContaier(vm: vm),
                    ),
                    context.emptySizedHeightBoxLow3x,
                  ],
                );
        },
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(LocaleKeys.settings_usernames.tr()),
    );
  }
}

class SocialAccountContaier extends StatelessWidget {
  const SocialAccountContaier({
    super.key,
    required this.vm,
  });

  final SettingsViewModel vm;

  @override
  Widget build(BuildContext context) {
    return StandartContainer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleMediumText(
              text: LocaleKeys.auth_register_snapchat.tr(),
            ),
            context.emptySizedHeightBoxLow,
            vm.snapchatInput,
            context.emptySizedHeightBoxLow3x,
            TitleMediumText(
              text: LocaleKeys.auth_register_instagram.tr(),
            ),
            context.emptySizedHeightBoxLow,
            vm.instagramInput,
            context.emptySizedHeightBoxLow3x,
            TitleMediumText(
              text: LocaleKeys.auth_register_twitter.tr(),
            ),
            context.emptySizedHeightBoxLow,
            vm.twitterInput,
            context.emptySizedHeightBoxLow3x,
            StandartTextButton(
              text: LocaleKeys.settings_updateUsernames.tr(),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
