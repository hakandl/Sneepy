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
import 'package:sneepy/product/constants/enums/number.dart';
import 'package:sneepy/product/constants/strings.dart';
import 'package:sneepy/product/init/language/locale_keys.g.dart';
import 'package:sneepy/product/init/string/string.dart';
import 'package:sneepy/product/widgets/card/select_card.dart';
import 'package:sneepy/product/widgets/container/standart_container.dart';
import 'package:sneepy/product/widgets/dialog/standart_dialog.dart';
import 'package:sneepy/product/widgets/text/title_medium_text.dart';
import 'package:url_launcher/url_launcher.dart';

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
                    const GeneralInformationContainer(),
                    context.emptySizedHeightBoxNormal,
                    const SneepyPrivacyPolicyAndLicensesContainer(),
                    context.emptySizedHeightBoxNormal,
                    LogOutAndDeleteAccountContainer(),
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

class GeneralInformationContainer extends StatelessWidget {
  const GeneralInformationContainer({
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
          const Divider(),
          SelectCard(
            title: TitleMediumText(
              text: LocaleKeys.settings_searchPreferences.tr(),
            ),
            onTap: () => context.navigateToPage(
              const SearchPreferences(),
            ),
          ),
          const Divider(),
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

class SneepyPrivacyPolicyAndLicensesContainer extends StatelessWidget {
  const SneepyPrivacyPolicyAndLicensesContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StandartContainer(
      child: Column(
        children: [
          SelectCard(
            title: TitleMediumText(
              text: LocaleKeys.settings_privacyPolicy.tr(),
            ),
            onTap: () {
              launchUrl(
                Uri.parse(AppStrings.sneepyPrivacyPolicy),
                mode: LaunchMode.externalApplication,
              );
            },
          ),
          const Divider(),
          SelectCard(
            title: TitleMediumText(
              text: LocaleKeys.settings_licenses.tr(),
            ),
            onTap: () {
              context.navigateToPage(
                Theme(
                  data: Theme.of(context).copyWith(
                    cardColor: context.colorScheme.onBackground,
                  ),
                  child: LicensePage(
                    applicationVersion: SneepyStringsInit.APP_VERSION,
                    applicationIcon: Padding(
                      padding: context.paddingNormal,
                      child: Image.asset(
                        AppStrings.sneepyLogo,
                        height: NumberEnum.sixtyFour.value,
                      ),
                    ),
                    applicationName: SneepyStringsInit.APP_NAME,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class LogOutAndDeleteAccountContainer extends StatelessWidget {
  LogOutAndDeleteAccountContainer({
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
            },
          ),
          const Divider(),
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
                  LocaleKeys.settings_areYouSureYouWantToDeleteYourAccount.tr(),
                ),
                buttonText: LocaleKeys.buttons_accept.tr(),
                buttonColor: context.colorScheme.error,
                onPressed: () async {
                  await deleteAccountAndGoToLoginView(context);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> logOut(BuildContext context) async {
    await vm.deleteToken();
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginView(),
        ),
      );
    }
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
