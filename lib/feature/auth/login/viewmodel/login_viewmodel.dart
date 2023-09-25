import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:sneepy/product/cache/hive_manager.dart';
import 'package:sneepy/product/constants/strings.dart';
import 'package:sneepy/product/init/language/locale_keys.g.dart';
import 'package:sneepy/product/init/notification/notification_init.dart';
import 'package:sneepy/product/models/response_model.dart';
import 'package:sneepy/product/utils/loading.dart';
import 'package:sneepy/product/widgets/input/standart_textfield.dart';

import '../../../../product/services/auth_service.dart';
part 'login_viewmodel.g.dart';

class LoginViewModel = _LoginViewModelBase with _$LoginViewModel;

abstract class _LoginViewModelBase with Store {
  final LoadingUtil loading = LoadingUtil();

  final notificationInit = NotificationInit();
  final deviceToken = HiveManager.get(key: BoxKeyNames.deviceToken.name);

  final emailInput = StandartTextField(
    text: LocaleKeys.auth_email.tr(),
    keyboardType: TextInputType.emailAddress,
  );
  final passwordInput = StandartTextField(
    text: LocaleKeys.auth_password.tr(),
    obscureText: true,
  );

  Future<void> saveDeviceToken() async {
    await notificationInit.saveDeviceToken();
    await AuthService().updateMe(
      deviceToken: deviceToken ?? AppStrings.empty,
    );
  }

  Future<void> saveToken(String value) async {
    await HiveManager.save(
      key: BoxKeyNames.token.name,
      value: value,
    );
  }

  Future<ResponseModel> login() async {
    loading.changeLoading();
    final response = await AuthService().login(
      email: emailInput.controller.text,
      password: passwordInput.controller.text,
    );
    loading.changeLoading();
    if (response.success == true) {
      await saveToken(response.data);
    }
    await saveDeviceToken();
    return response;
  }
}
