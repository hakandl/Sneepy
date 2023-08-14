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
    getCountries();
  }

  Future<void> getCountries() async {
    await vm.getCountries();
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
            const StandartContainer(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TurkishSelectCard(),
                    Divider(),
                    EnglishSelectCard(),
                    Divider(),
                    GermanSelectCard(),
                    Divider(),
                    RussianSelectCard(),
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

class TurkishSelectCard extends StatelessWidget {
  const TurkishSelectCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SelectCard(
      title: Text(LocaleKeys.languages_turkish.tr()),
      onTap: () => context.setLocale(
        const Locale(
          AppStrings.tr,
          AppStrings.TR,
        ),
      ),
    );
  }
}

class EnglishSelectCard extends StatelessWidget {
  const EnglishSelectCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SelectCard(
      title: Text(LocaleKeys.languages_english.tr()),
      onTap: () => context.setLocale(
        const Locale(
          AppStrings.en,
          AppStrings.US,
        ),
      ),
    );
  }
}

class GermanSelectCard extends StatelessWidget {
  const GermanSelectCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SelectCard(
      title: Text(LocaleKeys.languages_german.tr()),
      onTap: () => context.setLocale(
        const Locale(
          AppStrings.de,
          AppStrings.DE,
        ),
      ),
    );
  }
}

class RussianSelectCard extends StatelessWidget {
  const RussianSelectCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SelectCard(
      title: Text(LocaleKeys.languages_russian.tr()),
      onTap: () => context.setLocale(
        const Locale(
          AppStrings.ru,
          AppStrings.RU,
        ),
      ),
    );
  }
}
