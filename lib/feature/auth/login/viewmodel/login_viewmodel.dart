import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:sneepy/product/init/language/locale_keys.g.dart';
import 'package:sneepy/product/models/response_model.dart';
import 'package:sneepy/product/widgets/input/standart_textfield.dart';

import '../../../../product/services/auth_service.dart';
part 'login_viewmodel.g.dart';

class LoginViewModel = _LoginViewModelBase with _$LoginViewModel;

abstract class _LoginViewModelBase with Store {
  final emailInput = StandartTextField(
    text: LocaleKeys.auth_email.tr(),
    keyboardType: TextInputType.emailAddress,
  );
  final passwordInput = StandartTextField(
    text: LocaleKeys.auth_password.tr(),
    obscureText: true,
  );

  @observable
  bool isLoading = false;

  @action
  void changeLoading() {
    isLoading = !isLoading;
  }

  Future<ResponseModel> login() async {
    changeLoading();
    final response = await AuthService().login(
      email: emailInput.controller.text,
      password: passwordInput.controller.text,
    );
    changeLoading();
    return response;
  }
}
