import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:sneepy/feature/profie/settings/subview/information_view.dart';
import 'package:sneepy/feature/profie/settings/subview/photos_view.dart';
import 'package:sneepy/feature/profie/settings/subview/social_account_view.dart';
import 'package:sneepy/feature/profie/view/profile_view.dart';
import 'package:sneepy/product/constants/colors.dart';
import 'package:sneepy/product/init/language/locale_keys.g.dart';
import 'package:sneepy/product/widgets/card/select_card.dart';
import 'package:sneepy/product/widgets/container/standart_container.dart';
import 'package:sneepy/product/widgets/dialog/standart_dialog.dart';
import 'package:sneepy/product/widgets/text/title_medium_text.dart';

class ProfileSettingsView extends StatelessWidget {
  const ProfileSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Column(
        children: [
          context.emptySizedHeightBoxLow3x,
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const PersonalInformationContainer(),
                  context.emptySizedHeightBoxNormal,
                  const SneepyInformationContainer(),
                  context.emptySizedHeightBoxNormal,
                  const DeleteAccountContainer(),
                ],
              ),
            ),
          ),
          context.emptySizedHeightBoxLow3x,
        ],
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: Text(
        LocaleKeys.settings_settings.tr(),
      ),
      leading: BackButton(
        onPressed: () {
          context.navigateToPage(
            const ProfileView(),
          );
        },
      ),
    );
  }
}

class PersonalInformationContainer extends StatelessWidget {
  const PersonalInformationContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StandartContainer(
      child: Column(
        children: [
          SelectCard(
            title: TitleMediumText(
              text: LocaleKeys.settings_personalInformation.tr(),
            ),
            trailing: const Icon(
              Icons.arrow_forward_outlined,
            ),
            onTap: () => context.navigateToPage(
              const InformationView(),
            ),
          ),
          const Divider(),
          SelectCard(
            title: TitleMediumText(
              text: LocaleKeys.settings_usernames.tr(),
            ),
            trailing: const Icon(
              Icons.arrow_forward_outlined,
            ),
            onTap: () => context.navigateToPage(
              const SocialAccountView(),
            ),
          ),
          const Divider(),
          SelectCard(
            title: TitleMediumText(
              text: LocaleKeys.settings_photos.tr(),
            ),
            trailing: const Icon(
              Icons.arrow_forward_outlined,
            ),
            onTap: () => context.navigateToPage(
              PhotosView(),
            ),
          ),
        ],
      ),
    );
  }
}

class SneepyInformationContainer extends StatelessWidget {
  const SneepyInformationContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StandartContainer(
      child: Column(
        children: [
          SelectCard(
            title: TitleMediumText(
              text: LocaleKeys.settings_usernames.tr(),
            ),
            trailing: const Icon(
              Icons.arrow_forward_outlined,
            ),
            onTap: () => context.navigateToPage(
              PhotosView(),
            ),
          ),
          const Divider(),
          SelectCard(
            title: TitleMediumText(
              text: LocaleKeys.settings_licenses.tr(),
            ),
            trailing: const Icon(
              Icons.arrow_forward_outlined,
            ),
            onTap: () => showLicensePage(context: context),
          ),
        ],
      ),
    );
  }
}

class DeleteAccountContainer extends StatelessWidget {
  const DeleteAccountContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StandartContainer(
      child: Column(
        children: [
          SelectCard(
              title: TitleMediumText(
                text: LocaleKeys.settings_deleteAccount.tr(),
                color: AppColors.persimmon,
              ),
              trailing: const Icon(
                Icons.arrow_forward_outlined,
              ),
              onTap: () {
                showStandartDialog(
                  context,
                  title: LocaleKeys.settings_deleteAccount.tr(),
                  content: Text(
                    LocaleKeys.settings_areYouSureYouWantToDeleteYourAccount
                        .tr(),
                  ),
                  buttonText: LocaleKeys.buttons_accept.tr(),
                  buttonColor: AppColors.persimmon,
                  onPressed: () {},
                );
              }),
        ],
      ),
    );
  }
}

class SettingsListTile extends StatelessWidget {
  const SettingsListTile({
    super.key,
    required this.text,
    required this.onTap,
  });
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      title: TitleMediumText(
        text: text,
      ),
      trailing: const Icon(
        Icons.arrow_forward_outlined,
      ),
      onTap: onTap,
    );
  }
}
