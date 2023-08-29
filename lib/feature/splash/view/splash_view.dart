import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:sneepy/feature/splash/viewmodel/splash_viewmodel.dart';
import 'package:sneepy/product/constants/enums/number.dart';
import 'package:sneepy/product/constants/strings.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final SplashViewModel vm = SplashViewModel();

  @override
  void initState() {
    super.initState();
    vm.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.primary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.scale(
            scale: NumberEnum.zSeventyFive.value,
            child: Image.asset(
              AppStrings.sneepyLogo,
            ),
          ),
          vm.loading.isLoading
              ? CircularProgressIndicator(
                  color: context.colorScheme.onPrimary,
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}
