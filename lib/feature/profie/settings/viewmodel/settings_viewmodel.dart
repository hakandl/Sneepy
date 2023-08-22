import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:sneepy/product/constants/enums/gender.dart';
import 'package:sneepy/product/constants/enums/number.dart';
import 'package:sneepy/product/constants/service.dart';
import 'package:sneepy/product/constants/strings.dart';
import 'package:sneepy/product/init/language/locale_keys.g.dart';
import 'package:sneepy/product/models/countries_model.dart';
import 'package:sneepy/product/models/response_model.dart';
import 'package:sneepy/product/models/user_model.dart';
import 'package:sneepy/product/services/auth_service.dart';
import 'package:sneepy/product/services/countries_service.dart';
import 'package:sneepy/product/widgets/input/standart_textfield.dart';
part 'settings_viewmodel.g.dart';

class SettingsViewModel = _SettingsViewModelBase with _$SettingsViewModel;

abstract class _SettingsViewModelBase with Store {
  @observable
  bool isLoading = false;

  @action
  void changeLoading() {
    isLoading = !isLoading;
  }

  UserModel? me;

  List<CountriesModel> countries = [];

  String gender = Gender.none.name;

  @observable
  RangeValues ageRangeValues = RangeValues(
    NumberEnum.eighteen.value,
    NumberEnum.sixtyFive.value,
  );

  // information view
  final nameInput = StandartTextField(
    prefix: const Icon(FontAwesomeIcons.user),
  );
  final ageInput = StandartTextField(
    prefix: const Icon(FontAwesomeIcons.arrowUp19),
  );
  final genderInput = StandartTextField(
    prefix: const Icon(FontAwesomeIcons.arrowUp19),
    enabled: false,
  );

  // social accounts view
  final snapchatInput = StandartTextField(
    prefix: const Icon(FontAwesomeIcons.snapchat),
  );
  final instagramInput = StandartTextField(
    prefix: const Icon(FontAwesomeIcons.instagram),
  );
  final twitterInput = StandartTextField(
    prefix: const Icon(FontAwesomeIcons.twitter),
  );

  Future<void> getMe() async {
    changeLoading();
    me = await AuthService().getMe();
    changeLoading();
  }

  Future<void> deleteAccount() async {
    await AuthService().deleteMe();
  }

  Future<ResponseModel> updateInformation() async {
    changeLoading();
    final response = await AuthService().updateMe(
      name: nameInput.controller.text,
      age: ageInput.controller.text,
      gender: genderInput.controller.text == LocaleKeys.auth_register_woman.tr()
          ? ServiceConstants.female
          : ServiceConstants.male,
    );
    changeLoading();
    return response;
  }

  Future<ResponseModel> updateSocialAccounts() async {
    changeLoading();
    final response = await AuthService().updateMe(
      snapchat: snapchatInput.controller.text,
      instagram: instagramInput.controller.text,
      twitter: twitterInput.controller.text,
    );
    changeLoading();
    return response;
  }

  Future<ResponseModel> updateCountry(String country) async {
    changeLoading();
    final response = await AuthService().updateMe(
      country: country,
    );
    me = await AuthService().getMe();
    changeLoading();
    return response;
  }

  Future<void> getCountries() async {
    changeLoading();
    countries = await CountriesService().getAllCountries();
    changeLoading();
  }

  void selectGender() {
    if (gender == Gender.none.name || gender == Gender.male.name) {
      gender = Gender.female.name;
      genderInput.controller.text = LocaleKeys.auth_register_woman.tr();
    } else if (gender == Gender.female.name) {
      gender = Gender.male.name;
      genderInput.controller.text = LocaleKeys.auth_register_man.tr();
    }
    // TODO CİNSİYET SEÇİLİNCE GET USERS I FİLTRELE
  }

  void selectCountry(int index) {
    countries[index].name ?? AppStrings.empty;
    // TODO ÜLKE SEÇİLİNCE GET USERS I FİLTRELE
  }

  void initInformationView(UserModel user) {
    nameInput.controller.text = user.name ?? AppStrings.empty;
    ageInput.controller.text = user.age.toString();
    genderInput.controller.text = user.gender == ServiceConstants.female
        ? LocaleKeys.auth_register_woman.tr()
        : LocaleKeys.auth_register_man.tr();
  }

  void initSocialAccountsView(UserModel user) {
    snapchatInput.controller.text = user.snapchat ?? AppStrings.empty;
    instagramInput.controller.text = user.instagram ?? AppStrings.empty;
    twitterInput.controller.text = user.twitter ?? AppStrings.empty;
  }

  Future<ResponseModel> selectImageAndAddPhoto() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      changeLoading();
      final response =
          await AuthService().addPhoto(file: File(pickedFile.path));
      changeLoading();
      await getMe();
      return response;
    }
    return ResponseModel();
  }

  Future<ResponseModel> updatePhoto({
    required String photoId,
  }) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      changeLoading();
      final response = await AuthService().updatePhoto(
        file: File(pickedFile.path),
        photoId: photoId,
      );
      changeLoading();
      await getMe();
      return response;
    }
    return ResponseModel();
  }

  Future<ResponseModel> deletePhoto({
    required String photoId,
  }) async {
    changeLoading();
    final response = await AuthService().deletePhoto(photoId: photoId);
    changeLoading();
    await getMe();
    return response;
  }
}