import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';
import 'package:sneepy/feature/auth/register/viewmodel/register_viewmodel.dart';
import 'package:sneepy/feature/home/view/home_view.dart';
import 'package:sneepy/product/constants/colors.dart';
import 'package:sneepy/product/constants/enums/gender.dart';
import 'package:sneepy/product/constants/enums/number.dart';
import 'package:sneepy/product/constants/strings.dart';
import 'package:sneepy/product/init/language/locale_keys.g.dart';
import 'package:sneepy/product/models/response_model.dart';
import 'package:sneepy/product/widgets/button/standart_text_button.dart';
import 'package:sneepy/product/widgets/card/select_card.dart';
import 'package:sneepy/product/widgets/dialog/standart_dialog.dart';
import 'package:sneepy/product/widgets/modal/standart_modal_bottom_sheet.dart';
import 'package:sneepy/product/widgets/text/title_large_text.dart';

part 'register_step_views.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _vm = RegisterViewModel();

  @override
  void initState() {
    super.initState();
    getCountries();
  }

  Future<void> getCountries() async {
    await _vm.allCountries();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_vm.registerProgressValue > _vm.value) {
          _vm.backRegisterInfo();
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: context.horizontalPaddingNormal,
            child: Column(
              children: [
                context.emptySizedHeightBoxLow3x,
                Observer(builder: (_) {
                  return LinearProgressIndicator(
                    value: _vm.registerProgressValue,
                    color: AppColors.ebonyClay,
                    backgroundColor: AppColors.athensGray,
                  );
                }),
                context.emptySizedHeightBoxLow3x,
                Observer(
                  builder: (_) {
                    return Expanded(
                      child: Column(
                        children: [
                          if (_vm.screenMode == NumberEnum.one.value)
                            RegisterStep1Section(
                              vm: _vm,
                            ),
                          if (_vm.screenMode == NumberEnum.two.value)
                            RegisterStep2Section(
                              vm: _vm,
                            ),
                          if (_vm.screenMode == NumberEnum.three.value)
                            RegisterStep3Section(
                              vm: _vm,
                            ),
                          if (_vm.screenMode == NumberEnum.four.value)
                            Expanded(
                              child: RegisterStep4Section(
                                vm: _vm,
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
                Observer(builder: (_) {
                  return StandartTextButton(
                    text: _vm.screenMode != NumberEnum.four.value
                        ? LocaleKeys.buttons_continue.tr()
                        : LocaleKeys.buttons_complete.tr(),
                    isLoading: _vm.isLoading,
                    onPressed: _vm.isLoading
                        ? () {}
                        : () async {
                            if (_vm.screenMode == NumberEnum.one.value) {
                              await register(context);
                            } else if (_vm.screenMode == NumberEnum.two.value ||
                                _vm.screenMode == NumberEnum.three.value) {
                              await update(context);
                            } else if (_vm.screenMode ==
                                NumberEnum.four.value) {
                              if (_vm.image != null) {
                                goToHomeView(context);
                              } else {
                                showStandartDialog(
                                  context,
                                  title: LocaleKeys.thereIsProblem.tr(),
                                  content: Text(
                                    LocaleKeys
                                        .auth_register_toRegisterYouNeedToUploadPhotoToYourProfile
                                        .tr(),
                                  ),
                                );
                              }
                            }
                          },
                  );
                }),
                context.emptySizedHeightBoxLow3x,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> register(BuildContext context) async {
    final response = await _vm.register();
    if (response.success == true) {
      _vm.nextRegisterInfo();
    } else {
      if (context.mounted) {
        responseError(context, response);
      }
    }
  }

  Future<void> update(BuildContext context) async {
    final response = await _vm.update();
    if (response.success == true) {
      _vm.nextRegisterInfo();
    } else {
      if (context.mounted) {
        responseError(context, response);
      }
    }
  }

  Future<dynamic> goToHomeView(BuildContext context) {
    return Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeView(),
      ),
    );
  }
}

void responseError(BuildContext context, ResponseModel response) {
  showStandartDialog(
    context,
    title: LocaleKeys.thereIsProblem.tr(),
    content: Text(
      response.message ?? LocaleKeys.thereIsProblem.tr(),
    ),
  );
}
