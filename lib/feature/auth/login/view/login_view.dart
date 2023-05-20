import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';
import 'package:sneepy/feature/auth/login/viewmodel/login_viewmodel.dart';
import 'package:sneepy/feature/auth/register/view/register_view.dart';
import 'package:sneepy/product/widgets/button/standart_text_button.dart';
import 'package:sneepy/product/widgets/input/standart_textfield.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final _vm = LoginViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Text(
                'Giriş Yap',
                style: context.textTheme.headlineLarge,
              ),
              context.emptySizedHeightBoxNormal,
              const SizedBox(
                height: 50,
                child: StandartTextField(text: 'Email'),
              ),
              context.emptySizedHeightBoxLow,
              SizedBox(
                height: 50,
                child: Observer(builder: (_) {
                  return StandartTextField(
                    text: 'Şifre',
                    obscureText: _vm.isShowPassword,
                    suffix: IconButton(
                      icon: Icon(_vm.isShowPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                      onPressed: () {
                        _vm.showPassword();
                      },
                    ),
                  );
                }),
              ),
              context.emptySizedHeightBoxLow3x,
              StandartTextButton(
                text: 'Giriş Yap',
                onPressed: () {},
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Hesabın yok mu?'),
                  TextButton(
                    child: const Text('Kayıt ol'),
                    onPressed: () {
                      context.navigateToPage(RegisterView());
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
