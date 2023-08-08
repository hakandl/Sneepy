import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:sneepy/product/cache/hive_manager.dart';
import 'package:sneepy/product/constants/enums/gender.dart';
import 'package:sneepy/product/constants/service.dart';
import 'package:sneepy/product/constants/strings.dart';
import 'package:sneepy/product/init/language/locale_keys.g.dart';
import 'package:sneepy/product/models/countries_model.dart';
import 'package:sneepy/product/models/response_model.dart';
import 'package:sneepy/product/services/auth_service.dart';
import 'package:sneepy/product/services/countries_service.dart';
import 'package:sneepy/product/widgets/input/standart_textfield.dart';
part 'register_viewmodel.g.dart';

class RegisterViewModel = _RegisterViewModelBase with _$RegisterViewModel;

abstract class _RegisterViewModelBase with Store {
  final double value = 0.25;
  String? userToken;
  String gender = Gender.none.name;
  List<CountriesModel> countries = [];

  @observable
  int screenMode = 1;

  @observable
  late double registerProgressVaue = value;

  @observable
  bool isLoading = false;

  @action
  void changeLoading() {
    isLoading = !isLoading;
  }

  @action
  void nextRegisterInfo() {
    screenMode++;
    registerProgressVaue += value;
    if (screenMode == 4) {
      registerProgressVaue = 1;
    }
  }

  @action
  void backRegisterInfo() {
    screenMode--;
    registerProgressVaue -= value;
  }

  final nameInput = StandartTextField(
    text: LocaleKeys.auth_register_name.tr(),
  );
  final emailInput = StandartTextField(
    text: LocaleKeys.auth_email.tr(),
    keyboardType: TextInputType.emailAddress,
  );
  final passwordInput = StandartTextField(
    text: LocaleKeys.auth_password.tr(),
    obscureText: true,
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
      setImage(File(pickedFile.path));
      return await AuthService().addPhoto(file: File(pickedFile.path));
    }
    return ResponseModel();
  }

  // @observable
  // ObservableList<File?> images = ObservableList<File?>.of([null, null, null]);

  // @action
  // void setImage(int index, File? image) {
  //   images[index] = image;
  // }

  @observable
  File? image;

  @action
  void setImage(File? image) {
    this.image = image;
  }

  Future<ResponseModel> register() async {
    changeLoading();
    final response = await AuthService().register(
      name: nameInput.controller.text,
      email: emailInput.controller.text,
      password: passwordInput.controller.text,
    );
    changeLoading();
    if (response.success == true) {
      userToken = response.data['token'];
      await HiveManager.save(key: 'token', value: response.data);
    }
    return response;
  }

  Future<ResponseModel> update() async {
    changeLoading();
    final response = await AuthService().updateMe(
      age: ageInput.controller.text,
      gender: genderInput.controller.text == LocaleKeys.auth_register_woman.tr()
          ? ServiceConstants.female
          : ServiceConstants.male,
      country: countryInput.controller.text,
      snapchat: snapchatInput.controller.text,
      instagram: instagramInput.controller.text,
      twitter: twitterInput.controller.text,
    );
    changeLoading();
    return response;
  }
}
