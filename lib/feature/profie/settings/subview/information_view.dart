import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';
import 'package:sneepy/feature/profie/settings/viewmodel/settings_viewmodel.dart';
import 'package:sneepy/product/constants/enums/gender.dart';
import 'package:sneepy/product/init/language/locale_keys.g.dart';
import 'package:sneepy/product/models/user_model.dart';
import 'package:sneepy/product/widgets/card/select_card.dart';
import 'package:sneepy/product/widgets/container/standart_container.dart';
import 'package:sneepy/product/widgets/dialog/standart_dialog.dart';
import 'package:sneepy/product/widgets/modal/standart_modal_bottom_sheet.dart';
import 'package:sneepy/product/widgets/text/title_medium_text.dart';

import '../../../../product/widgets/button/standart_text_button.dart';

class InformationView extends StatefulWidget {
  const InformationView({super.key});

  @override
  State<InformationView> createState() => _InformationViewState();
}

class _InformationViewState extends State<InformationView> {
  final SettingsViewModel vm = SettingsViewModel();

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    await vm.getMe();
    vm.initInformationView(vm.me ?? UserModel());
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
                      child: PersonalInformationContainer(vm: vm),
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
      title: Text(
        LocaleKeys.profile_someInformation.tr(),
      ),
    );
  }
}

class PersonalInformationContainer extends StatelessWidget {
  const PersonalInformationContainer({
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
              text: LocaleKeys.auth_register_name.tr(),
            ),
            context.emptySizedHeightBoxLow,
            vm.nameInput,
            context.emptySizedHeightBoxLow3x,
            TitleMediumText(
              text: LocaleKeys.auth_register_age.tr(),
            ),
            context.emptySizedHeightBoxLow,
            vm.ageInput,
            context.emptySizedHeightBoxLow3x,
            TitleMediumText(
              text: LocaleKeys.auth_register_gender.tr(),
            ),
            context.emptySizedHeightBoxLow,
            InkWell(
              child: vm.genderInput,
              onTap: () => genderModalBottomSheet(context),
            ),
            context.emptySizedHeightBoxLow3x,
            Observer(builder: (_) {
              return StandartTextButton(
                text: LocaleKeys.settings_updateInformation.tr(),
                isLoading: vm.isLoading,
                onPressed: () async {
                  await update(context);
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  Future<void> update(BuildContext context) async {
    final response = await vm.updateInformation();
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
              value: vm.gender == Gender.female.name,
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
              value: vm.gender == Gender.male.name,
              groupValue: true,
              onChanged: (value) => selectGender(context),
            ),
            onTap: () => selectGender(context),
          ),
        ],
      ),
    );
  }

  void selectGender(BuildContext context) {
    vm.selectGender();
    context.pop();
  }
}
