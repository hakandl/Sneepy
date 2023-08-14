import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:sneepy/feature/profie/settings/view/profile_settings_view.dart';
import 'package:sneepy/feature/profie/settings/viewmodel/settings_viewmodel.dart';
import 'package:sneepy/product/constants/strings.dart';
import 'package:sneepy/product/init/language/locale_keys.g.dart';
import 'package:sneepy/product/widgets/card/select_card.dart';
import 'package:sneepy/product/widgets/container/standart_container.dart';

class LanguagesView extends StatefulWidget {
  const LanguagesView({super.key});

  @override
  State<LanguagesView> createState() => _LanguagesViewState();
}

class _LanguagesViewState extends State<LanguagesView> {
  final SettingsViewModel vm = SettingsViewModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.navigateToPage(const ProfileSettingsView());
        return false;
      },
      child: Scaffold(
        appBar: _appBar(context),
        body: Column(
          children: [
            context.emptySizedHeightBoxLow3x,
            StandartContainer(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SelectCard(
                      title: Text(LocaleKeys.languages_turkish.tr()),
                      onTap: () => context.setLocale(
                        const Locale(
                          AppStrings.tr,
                          AppStrings.TR,
                        ),
                      ),
                    ),
                    const Divider(),
                    SelectCard(
                      title: Text(LocaleKeys.languages_english.tr()),
                      onTap: () => context.setLocale(
                        const Locale(
                          AppStrings.en,
                          AppStrings.US,
                        ),
                      ),
                    ),
                    const Divider(),
                    SelectCard(
                      title: Text(LocaleKeys.languages_german.tr()),
                      onTap: () => context.setLocale(
                        const Locale(
                          AppStrings.de,
                          AppStrings.DE,
                        ),
                      ),
                    ),
                    const Divider(),
                    SelectCard(
                      title: Text(LocaleKeys.languages_russian.tr()),
                      onTap: () => context.setLocale(
                        const Locale(
                          AppStrings.ru,
                          AppStrings.RU,
                        ),
                      ),
                    ),
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
      title: Text(LocaleKeys.settings_language.tr()),
      leading: BackButton(
        onPressed: () {
          context.navigateToPage(const ProfileSettingsView());
        },
      ),
    );
  }
}
