import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kartal/kartal.dart';
import 'package:sneepy/feature/auth/register/viewmodel/register_viewmodel.dart';
import 'package:sneepy/feature/home/view/home_view.dart';
import 'package:sneepy/product/constant/colors.dart';
import 'package:sneepy/product/widgets/button/standart_text_button.dart';
import 'package:sneepy/product/widgets/input/standart_textfield.dart';
import 'package:sneepy/product/widgets/text/title_large_text.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final _vm = RegisterViewModel();

  final nameInput = const StandartTextField(text: 'Ad');
  final emailInput = const StandartTextField(text: 'Email');
  final passwordInput = const StandartTextField(text: 'Şifre', obscureText: true);

  final ageInput = const StandartTextField(text: 'Yaş');

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_vm.registerProgressVaue >= 0.34) {
          _vm.backRegisterInfo();
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                const SizedBox(height: 25),
                Observer(builder: (_) {
                  return LinearProgressIndicator(
                    value: _vm.registerProgressVaue,
                    backgroundColor: const Color(0xffD1D4DB),
                  );
                }),
                const SizedBox(height: 25),
                Observer(
                  builder: (_) {
                    return Expanded(
                      child: Column(
                        children: [
                          if (_vm.screenMode == 1) _registerStep1Section(context),
                          if (_vm.screenMode == 2) _registerStep2Section(context),
                          if (_vm.screenMode == 3) Expanded(child: _registerStep3Section(context)),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 25),
                // const Spacer(),
                Observer(builder: (_) {
                  return StandartTextButton(
                    text: _vm.screenMode != 3 ? 'Devam et' : 'Tamamla',
                    onPressed: () {
                      if (_vm.screenMode != 3) {
                        _vm.nextRegisterInfo();
                      } else {
                        context.navigateToPage(const HomeView());
                      }
                    },
                  );
                }),
                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _registerStep1Section(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleLargeText(text: 'Kayıt olmak için bu gerekli bilgileri girmelisin.'),
        context.emptySizedHeightBoxLow3x,
        nameInput,
        context.emptySizedHeightBoxLow,
        emailInput,
        context.emptySizedHeightBoxLow,
        passwordInput,
      ],
    );
  }

  Column _registerStep2Section(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleLargeText(text: 'Şimdi de bazı kişisel bilgilerin ile devam edelim.'),
        context.emptySizedHeightBoxLow3x,
        ageInput,
        context.emptySizedHeightBoxLow,
      ],
    );
  }

  Widget _registerStep3Section(BuildContext context) {
    Future<File?> selectImage() async {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        return File(pickedFile.path);
      }
      return null;
    }

    return Column(
      children: [
        const TitleLargeText(text: 'Son olarak da birkaç fotoğraf ekleyelim.'),
        const SizedBox(height: 25),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 9 / 16,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () async {
                  final image = await selectImage();
                  if (image != null) {
                    _vm.setImage(index, image);
                  }
                },
                borderRadius: context.normalBorderRadius,
                child: Observer(
                  builder: (context) => Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: context.normalBorderRadius,
                      color: AppColors.athensGray,
                    ),
                    child: _vm.images[index] != null
                        ? ClipRRect(
                            borderRadius: context.normalBorderRadius,
                            child: Image.file(
                              _vm.images[index]!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Icon(
                            Icons.add_circle_outline,
                            size: 72,
                            color: AppColors.blueRibbon,
                          ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
