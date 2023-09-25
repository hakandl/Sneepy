import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';
import 'package:sneepy/feature/auth/login/viewmodel/login_viewmodel.dart';
import 'package:sneepy/feature/auth/register/view/register_view.dart';
import 'package:sneepy/feature/home/view/home_view.dart';
import 'package:sneepy/product/init/language/locale_keys.g.dart';
import 'package:sneepy/product/init/theme/theme_colors.dart';
import 'package:sneepy/product/widgets/button/standart_text_button.dart';
import 'package:sneepy/product/widgets/dialog/standart_dialog.dart';
import 'package:sneepy/product/widgets/text/title_medium_text.dart';

import '../../../../product/widgets/text/headline_large_text.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final _vm = LoginViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SneepyThemeColors().systemOverlayStyleDark,
        child: SafeArea(
          child: Padding(
            padding: context.horizontalPaddingNormal,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                HeadlineLargeText(
                  text: LocaleKeys.auth_login_login.tr(),
                ),
                context.emptySizedHeightBoxNormal,
                _vm.emailInput,
                context.emptySizedHeightBoxLow,
                _vm.passwordInput,
                context.emptySizedHeightBoxLow3x,
                Observer(builder: (_) {
                  return StandartTextButton(
                    text: LocaleKeys.auth_login_login.tr(),
                    isLoading: _vm.loading.isLoading,
                    onPressed: () => _login(context),
                  );
                }),
                const Spacer(),
                const DontYouHaveAnAccountWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _login(BuildContext context) async {
    final response = await _vm.login();
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
    } else {
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeView(),
          ),
        );
      }
    }
  }
}

class DontYouHaveAnAccountWidget extends StatelessWidget {
  const DontYouHaveAnAccountWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TitleMediumText(
          text: LocaleKeys.auth_login_dontYouHaveAnAccount.tr(),
        ),
        TextButton(
          child: TitleMediumText(
            text: LocaleKeys.buttons_register.tr(),
            color: context.colorScheme.primary,
          ),
          onPressed: () {
            context.navigateToPage(
              const RegisterView(),
            );
          },
        ),
      ],
    );
  }
}
