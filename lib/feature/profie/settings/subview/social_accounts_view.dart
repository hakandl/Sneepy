import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';
import 'package:sneepy/feature/profie/settings/viewmodel/settings_viewmodel.dart';
import 'package:sneepy/product/init/language/locale_keys.g.dart';
import 'package:sneepy/product/models/user_model.dart';
import 'package:sneepy/product/widgets/container/standart_container.dart';
import 'package:sneepy/product/widgets/dialog/standart_dialog.dart';
import 'package:sneepy/product/widgets/text/title_medium_text.dart';

import '../../../../product/widgets/button/standart_text_button.dart';

class SocialAccountsView extends StatefulWidget {
  const SocialAccountsView({super.key});

  @override
  State<SocialAccountsView> createState() => _SocialAccountsViewState();
}

class _SocialAccountsViewState extends State<SocialAccountsView> {
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
          return vm.loading.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    context.emptySizedHeightBoxLow3x,
                    Flexible(
                      child: SocialAccountsContaier(vm: vm),
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

class SocialAccountsContaier extends StatelessWidget {
  const SocialAccountsContaier({
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
              onPressed: () async {
                await update(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> update(BuildContext context) async {
    final response = await vm.updateSocialAccounts();
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
}
