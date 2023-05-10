import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:sneepy/feature/auth/register/view/register_view.dart';
import 'package:sneepy/product/widgets/button/standart_button.dart';
import 'package:sneepy/product/widgets/input/standart_textfield.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

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
                style: context.textTheme.titleLarge,
              ),
              context.emptySizedHeightBoxNormal,
              const SizedBox(
                height: 50,
                child: StandartTextField(text: 'Email'),
              ),
              context.emptySizedHeightBoxLow3x,
              const SizedBox(
                height: 50,
                child: StandartTextField(text: 'Şifre', obscureText: true),
              ),
              context.emptySizedHeightBoxLow3x,
              StandartButton(
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
                      context.navigateToPage(const RegisterView());
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
