import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';
import 'package:sneepy/feature/profie/settings/viewmodel/settings_viewmodel.dart';
import 'package:sneepy/product/constants/enums/number.dart';
import 'package:sneepy/product/constants/strings.dart';
import 'package:sneepy/product/init/language/locale_keys.g.dart';
import 'package:sneepy/product/models/countries_model.dart';
import 'package:sneepy/product/widgets/card/select_card.dart';
import 'package:sneepy/product/widgets/container/standart_container.dart';
import 'package:sneepy/product/widgets/dialog/standart_dialog.dart';
import 'package:sneepy/product/widgets/modal/standart_modal_bottom_sheet.dart';

class CountryView extends StatefulWidget {
  const CountryView({super.key});

  @override
  State<CountryView> createState() => _CountryViewState();
}

class _CountryViewState extends State<CountryView> {
  final SettingsViewModel vm = SettingsViewModel();

  @override
  void initState() {
    super.initState();
    getMe();
    getCountries();
  }

  Future<void> getMe() async {
    await vm.getMe();
  }

  Future<void> getCountries() async {
    await vm.getCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.auth_register_country.tr()),
      ),
      body: Column(
        children: [
          context.emptySizedHeightBoxLow3x,
          StandartContainer(
            child: SelectCard(
              title: Observer(builder: (_) {
                return vm.isLoading
                    ? const Align(
                        alignment: Alignment.centerLeft,
                        child: CircularProgressIndicator(),
                      )
                    : Text(
                        vm.me?.country ?? AppStrings.empty,
                      );
              }),
              onTap: () => countriesModalBottomSheet(context),
            ),
          ),
          context.emptySizedHeightBoxLow3x,
        ],
      ),
    );
  }

  Future<dynamic> countriesModalBottomSheet(BuildContext context) {
    return showStandartModalBottomSheet(
      context,
      child: ListView.builder(
        itemCount: vm.countries.length,
        itemBuilder: (BuildContext context, int index) {
          final currentCountry = vm.countries[index];
          return SelectCard(
            leading: Transform.scale(
              scale: NumberEnum.oneFive.value,
              child: Text(
                currentCountry.emoji ?? AppStrings.empty,
              ),
            ),
            title: Text(
              currentCountry.name ?? AppStrings.empty,
            ),
            onTap: () async {
              await selectCountryAndUpdate(currentCountry, context);
            },
          );
        },
      ),
    );
  }

  Future<void> selectCountryAndUpdate(
      CountriesModel currentCountry, BuildContext context) async {
    final response = await vm.updateCountry(
      currentCountry.name ?? AppStrings.empty,
    );
    if (context.mounted) {
      context.pop();
    }
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
