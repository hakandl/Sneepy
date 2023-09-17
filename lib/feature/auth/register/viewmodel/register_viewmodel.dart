import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kartal/kartal.dart';
import 'package:mobx/mobx.dart';
import 'package:sneepy/product/cache/hive_manager.dart';
import 'package:sneepy/product/constants/enums/gender.dart';
import 'package:sneepy/product/constants/enums/number.dart';
import 'package:sneepy/product/constants/service.dart';
import 'package:sneepy/product/constants/strings.dart';
import 'package:sneepy/product/init/language/locale_keys.g.dart';
import 'package:sneepy/product/init/product/notification_init.dart';
import 'package:sneepy/product/models/countries_model.dart';
import 'package:sneepy/product/models/response_model.dart';
import 'package:sneepy/product/services/auth_service.dart';
import 'package:sneepy/product/services/countries_service.dart';
import 'package:sneepy/product/utils/loading.dart';
import 'package:sneepy/product/widgets/input/standart_textfield.dart';
part 'register_viewmodel.g.dart';

class RegisterViewModel = _RegisterViewModelBase with _$RegisterViewModel;

abstract class _RegisterViewModelBase with Store {
  final LoadingUtil loading = LoadingUtil();
  final NotificationInit notification = NotificationInit();

  final double value = NumberEnum.zTwentyFive.value;
  String? userToken;
  String gender = Gender.none.name;
  List<CountriesModel> countries = [];
  final deviceToken = HiveManager.get(key: BoxKeyNames.deviceToken.name);

  @observable
  int screenMode = NumberEnum.one.value.toInt();

  @observable
  late double registerProgressValue = value;

  final nameInput = StandartTextField(
      text: LocaleKeys.auth_register_name.tr(),
      validator: (value) {
        if ((value?.length ?? NumberEnum.zero.value) < NumberEnum.two.value) {
          return LocaleKeys.auth_register_nameMustBeMinimumOf2Characters.tr();
        }
        return null;
      });
  final emailInput = StandartTextField(
    text: LocaleKeys.auth_email.tr(),
    keyboardType: TextInputType.emailAddress,
    validator: (value) {
      if (!value.isValidEmail) {
        return LocaleKeys.auth_register_pleaseEnterValidEmail.tr();
      }
      return null;
    },
  );
  final passwordInput = StandartTextField(
    text: LocaleKeys.auth_password.tr(),
    obscureText: true,
    validator: (value) {
      if ((value?.length ?? NumberEnum.zero.value) < NumberEnum.six.value) {
        return LocaleKeys.auth_register_passwordMustBeMinimumOf6Characters.tr();
      }
      return null;
    },
  );

  final ageInput = StandartTextField(
    text: LocaleKeys.auth_register_age.tr(),
    keyboardType: TextInputType.number,
  );
  final genderInput = StandartTextField(
    text: LocaleKeys.auth_register_gender.tr(),
    enabled: false,
  );
  final countryInput = StandartTextField(
    text: LocaleKeys.auth_register_country.tr(),
    enabled: false,
  );

  final snapchatInput = StandartTextField(
    text: LocaleKeys.auth_register_snapchat.tr(),
  );
  final instagramInput = StandartTextField(
    text: LocaleKeys.auth_register_instagram.tr(),
  );
  final twitterInput = StandartTextField(
    text: LocaleKeys.auth_register_twitter.tr(),
  );

  Future<void> init() async {
    await allCountries();
  }

  @action
  void nextRegisterInfo() {
    screenMode++;
    registerProgressValue += value;
    if (screenMode == NumberEnum.four.value) {
      registerProgressValue = NumberEnum.one.value;
    }
  }

  @action
  void backRegisterInfo() {
    screenMode--;
    registerProgressValue -= value;
  }

  void selectGender() {
    if (gender == Gender.none.name || gender == Gender.male.name) {
      gender = Gender.female.name;
      genderInput.controller.text = LocaleKeys.auth_register_woman.tr();
    } else if (gender == Gender.female.name) {
      gender = Gender.male.name;
      genderInput.controller.text = LocaleKeys.auth_register_man.tr();
    }
  }

  void selectCountry(int index) {
    countryInput.controller.text = countries[index].name ?? AppStrings.empty;
  }

  Future<void> allCountries() async {
    countries = await CountriesService().getAllCountries();
  }

  Future<ResponseModel> selectImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      loading.changeLoading();
      final croppedFile =
          await ImageCropper().cropImage(sourcePath: pickedFile.path);
      if (croppedFile != null) {
        setImage(
          File(croppedFile.path),
        );
        final response = await AuthService().addPhoto(
          file: File(croppedFile.path),
        );
        loading.changeLoading();
        return response;
      }
      loading.changeLoading();
    }
    return ResponseModel();
  }

  @observable
  File? image;

  @action
  void setImage(File? image) {
    this.image = image;
  }

  Future<void> saveToken(String value) async {
    await HiveManager.save(
      key: BoxKeyNames.token.name,
      value: value,
    );
  }

  Future<ResponseModel> register() async {
    loading.changeLoading();
    final response = await AuthService().register(
      name: nameInput.controller.text,
      email: emailInput.controller.text,
      password: passwordInput.controller.text,
      deviceToken: deviceToken ?? AppStrings.empty,
    );
    loading.changeLoading();
    if (response.success == true) {
      userToken = response.data['token'];
      await saveToken(userToken ?? AppStrings.empty);
    }
    return response;
  }

  Future<ResponseModel> update() async {
    loading.changeLoading();
    String age = ageInput.controller.text;
    if (ageInput.controller.text.isEmpty) {
      age = NumberEnum.eighteen.value.toString();
    }
    final response = await AuthService().updateMe(
      age: age,
      gender: genderInput.controller.text == LocaleKeys.auth_register_woman.tr()
          ? ServiceConstants.female
          : ServiceConstants.male,
      country: countryInput.controller.text,
      snapchat: snapchatInput.controller.text,
      instagram: instagramInput.controller.text,
      twitter: twitterInput.controller.text,
    );
    loading.changeLoading();
    return response;
  }
}
