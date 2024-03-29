import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:mobx/mobx.dart';
import 'package:sneepy/feature/auth/login/view/login_view.dart';
import 'package:sneepy/feature/home/view/home_view.dart';
import 'package:sneepy/product/cache/hive_manager.dart';
import 'package:sneepy/product/services/auth_service.dart';
import 'package:sneepy/product/utils/loading.dart';
part 'splash_viewmodel.g.dart';

class SplashViewModel = _SplashViewModelBase with _$SplashViewModel;

abstract class _SplashViewModelBase with Store {
  final LoadingUtil loading = LoadingUtil();

  Future<void> init(BuildContext context) async {
    await checkAuth(context);
    if (context.mounted) {
      await saveLocale(context);
    }
  }

  Future<void> saveLocale(BuildContext context) async {
    await HiveManager.save(
      key: BoxKeyNames.locale.name,
      value: context.locale.languageCode,
    );
  }

  Future<void> checkAuth(BuildContext context) async {
    loading.changeLoading();
    final response = await AuthService().checkAuth();
    loading.changeLoading();
    if (response.success == true) {
      if (context.mounted) {
        context.navigation.pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomeView(),
          ),
        );
      }
    } else {
      if (context.mounted) {
        context.navigation.pushReplacement(
          MaterialPageRoute(
            builder: (context) => LoginView(),
          ),
        );
      }
    }
  }
}
