import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:sneepy/feature/auth/login/view/login_view.dart';
import 'package:sneepy/feature/profie/settings/subview/country_view.dart';
import 'package:sneepy/feature/profie/settings/subview/information_view.dart';
import 'package:sneepy/feature/profie/settings/subview/languages_view.dart';
import 'package:sneepy/feature/profie/settings/subview/photos_view.dart';
import 'package:sneepy/feature/profie/settings/subview/search_preferences_view.dart';
import 'package:sneepy/feature/profie/settings/subview/social_accounts_view.dart';
import 'package:sneepy/feature/profie/settings/viewmodel/settings_viewmodel.dart';
import 'package:sneepy/feature/profie/view/profile_view.dart';
import 'package:sneepy/product/init/language/locale_keys.g.dart';
import 'package:sneepy/product/widgets/card/select_card.dart';
import 'package:sneepy/product/widgets/container/standart_container.dart';
import 'package:sneepy/product/widgets/dialog/standart_dialog.dart';
import 'package:sneepy/product/widgets/text/title_medium_text.dart';

class ProfileSettingsView extends StatelessWidget {
  const ProfileSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.navigateToPage(
          const ProfileView(),
        );
        return false;
      },
      child: Scaffold(
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
                    const SearchPreferencesContainer(),
                    context.emptySizedHeightBoxNormal,
                    const SneepyLanguagesContainer(),
                    context.emptySizedHeightBoxNormal,
                    const SneepyInformationContainer(),
                    context.emptySizedHeightBoxNormal,
                    DeleteAccountContainer(),
                    context.emptySizedHeightBoxNormal,
                    LogOutContainer(),
                  ],
                ),
              ),
            ),
            context.emptySizedHeightBoxLow3x,
          ],
        ),
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
            onTap: () => context.navigateToPage(
              const InformationView(),
            ),
          ),
          const Divider(),
          SelectCard(
            title: TitleMediumText(
              text: LocaleKeys.settings_usernames.tr(),
            ),
            onTap: () => context.navigateToPage(
              const SocialAccountsView(),
            ),
          ),
          const Divider(),
          SelectCard(
            title: TitleMediumText(
              text: LocaleKeys.settings_photos.tr(),
            ),
            onTap: () => context.navigateToPage(
              const PhotosView(),
            ),
          ),
          const Divider(),
          SelectCard(
            title: TitleMediumText(
              text: LocaleKeys.auth_register_country.tr(),
            ),
            onTap: () => context.navigateToPage(
              const CountryView(),
            ),
          ),
        ],
      ),
    );
  }
}

class SearchPreferencesContainer extends StatelessWidget {
  const SearchPreferencesContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StandartContainer(
      child: SelectCard(
        title: Text(LocaleKeys.settings_searchPreferences.tr()),
        onTap: () => context.navigateToPage(
          const SearchPreferences(),
        ),
      ),
    );
  }
}

class SneepyLanguagesContainer extends StatelessWidget {
  const SneepyLanguagesContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StandartContainer(
      child: Column(
        children: [
          SelectCard(
            title: TitleMediumText(
              text: LocaleKeys.settings_language.tr(),
            ),
            onTap: () => context.navigateToPage(
              const LanguagesView(),
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
              text: LocaleKeys.settings_licenses.tr(),
            ),
            onTap: () => showLicensePage(context: context),
          ),
        ],
      ),
    );
  }
}

class DeleteAccountContainer extends StatelessWidget {
  DeleteAccountContainer({
    super.key,
  });

  final SettingsViewModel vm = SettingsViewModel();

  @override
  Widget build(BuildContext context) {
    return StandartContainer(
      child: Column(
        children: [
          SelectCard(
              title: TitleMediumText(
                text: LocaleKeys.settings_deleteAccount.tr(),
                color: context.colorScheme.error,
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
                  buttonColor: context.colorScheme.error,
                  onPressed: () async {
                    await deleteAccountAndGoToLoginView(context);
                  },
                );
              }),
        ],
      ),
    );
  }

  Future<void> deleteAccountAndGoToLoginView(BuildContext context) async {
    await vm.deleteAccount();
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginView(),
        ),
      );
    }
  }
}

class LogOutContainer extends StatelessWidget {
  LogOutContainer({
    super.key,
  });

  final SettingsViewModel vm = SettingsViewModel();

  @override
  Widget build(BuildContext context) {
    return StandartContainer(
      child: Column(
        children: [
          SelectCard(
              title: TitleMediumText(
                text: LocaleKeys.buttons_logout.tr(),
                color: context.colorScheme.error,
              ),
              trailing: const Icon(
                Icons.arrow_forward_outlined,
              ),
              onTap: () {
                logOut(context);
              }),
        ],
      ),
    );
  }

  void logOut(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginView(),
      ),
    );
  }
}
