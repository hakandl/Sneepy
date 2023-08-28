import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';
import 'package:sneepy/feature/profie/settings/viewmodel/settings_viewmodel.dart';
import 'package:sneepy/product/cache/hive_manager.dart';
import 'package:sneepy/product/constants/enums/number.dart';
import 'package:sneepy/product/constants/service.dart';
import 'package:sneepy/product/constants/strings.dart';
import 'package:sneepy/product/init/language/locale_keys.g.dart';
import 'package:sneepy/product/widgets/card/select_card.dart';
import 'package:sneepy/product/widgets/container/standart_container.dart';

import '../../../../product/widgets/modal/standart_modal_bottom_sheet.dart';

class SearchPreferences extends StatefulWidget {
  const SearchPreferences({super.key});

  @override
  State<SearchPreferences> createState() => _SearchPreferencesState();
}

class _SearchPreferencesState extends State<SearchPreferences> {
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
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: [
          context.emptySizedHeightBoxLow3x,
          StandartContainer(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectCard(
                      title: Text(LocaleKeys.auth_register_age.tr()),
                      onTap: () async {
                        await ageModalBottomSheet(context);
                      }),
                  const Divider(),
                  SelectCard(
                    title: Text(LocaleKeys.auth_register_gender.tr()),
                    onTap: () => genderModalBottomSheet(context),
                  ),
                  const Divider(),
                  SelectCard(
                    title: Text(LocaleKeys.auth_register_country.tr()),
                    onTap: () => countriesModalBottomSheet(context),
                  ),
                ],
              ),
            ),
          ),
          context.emptySizedHeightBoxLow3x,
        ],
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(LocaleKeys.settings_searchPreferences.tr()),
    );
  }

  Future<dynamic> ageModalBottomSheet(BuildContext context) {
    return showStandartModalBottomSheet(context,
        isDynamicHeight: true,
        child: Padding(
          padding: context.paddingNormal,
          child: Observer(builder: (_) {
            return Slider(
              value: vm.ageValue,
              min: NumberEnum.eighteen.value,
              max: NumberEnum.sixtyFive.value,
              divisions: NumberEnum.fortySeven.value.toInt(),
              label: vm.ageValue.toInt().toString(),
              onChanged: (value) {
                vm.selectAge(value);
              },
            );
          }),
        ));
  }

  Future<dynamic> genderModalBottomSheet(BuildContext context) {
    return showStandartModalBottomSheet(
      context,
      isDynamicHeight: true,
      child: Column(
        children: [
          SelectCard(
            leading: const Icon(Icons.female),
            title: Text(
              LocaleKeys.auth_register_woman.tr(),
            ),
            trailing: Radio(
              value: HiveManager.get(key: BoxKeyNames.gender.name) ==
                  ServiceConstants.female,
              groupValue: true,
              onChanged: (value) => selectGender(context),
            ),
            onTap: () => selectGender(context),
          ),
          SelectCard(
            leading: const Icon(Icons.male),
            title: Text(
              LocaleKeys.auth_register_man.tr(),
            ),
            trailing: Radio(
              value: HiveManager.get(key: BoxKeyNames.gender.name) ==
                  ServiceConstants.male,
              groupValue: true,
              onChanged: (value) => selectGender(context),
            ),
            onTap: () => selectGender(context),
          ),
        ],
      ),
    );
  }

  Future<dynamic> countriesModalBottomSheet(BuildContext context) {
    return showStandartModalBottomSheet(
      context,
      child: ListView.separated(
        itemCount: vm.countries.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          final currentCountry = vm.countries[index];
          return SelectCard(
            title: Text(
              currentCountry.name ?? AppStrings.empty,
            ),
            leading: Transform.scale(
              scale: NumberEnum.oneFive.value,
              child: Text(
                currentCountry.emoji ?? AppStrings.empty,
              ),
            ),
            onTap: () => selectCountry(index, context),
          );
        },
        separatorBuilder: (context, index) => Divider(
          color: context.colorScheme.background,
        ),
      ),
    );
  }

  void selectGender(BuildContext context) {
    vm.selectGender();
    context.pop();
  }

  void selectCountry(int index, BuildContext context) {
    vm.selectCountry(index);
    context.pop();
  }
}
