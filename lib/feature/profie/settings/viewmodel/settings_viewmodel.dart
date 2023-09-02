import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:sneepy/product/cache/hive_manager.dart';
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
import 'package:sneepy/product/utils/loading.dart';
import 'package:sneepy/product/widgets/input/standart_textfield.dart';
part 'settings_viewmodel.g.dart';

class SettingsViewModel = _SettingsViewModelBase with _$SettingsViewModel;

abstract class _SettingsViewModelBase with Store {
  final LoadingUtil loading = LoadingUtil();

  UserModel? me;

  List<CountriesModel> countries = [];

  String gender = Gender.none.name;

  @observable
  double ageValue = NumberEnum.eighteen.value;

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
    loading.changeLoading();
    me = await AuthService().getMe();
    loading.changeLoading();
  }

  Future<void> deleteAccount() async {
    await AuthService().deleteMe();
  }

  Future<void> deleteToken() async {
    await HiveManager.delete(key: BoxKeyNames.token.name);
  }

  Future<ResponseModel> updateInformation() async {
    loading.changeLoading();
    final response = await AuthService().updateMe(
      name: nameInput.controller.text,
      age: ageInput.controller.text,
      gender: genderInput.controller.text == LocaleKeys.auth_register_woman.tr()
          ? ServiceConstants.female
          : ServiceConstants.male,
    );
    loading.changeLoading();
    return response;
  }

  Future<ResponseModel> updateSocialAccounts() async {
    loading.changeLoading();
    final response = await AuthService().updateMe(
      snapchat: snapchatInput.controller.text,
      instagram: instagramInput.controller.text,
      twitter: twitterInput.controller.text,
    );
    loading.changeLoading();
    return response;
  }

  Future<ResponseModel> updateCountry(String country) async {
    loading.changeLoading();
    final response = await AuthService().updateMe(
      country: country,
    );
    me = await AuthService().getMe();
    loading.changeLoading();
    return response;
  }

  Future<void> getCountries() async {
    loading.changeLoading();
    countries = await CountriesService().getAllCountries();
    loading.changeLoading();
  }

  Future<void> selectAge(double value) async {
    ageValue = value;
    await HiveManager.save(
      key: BoxKeyNames.age.name,
      value: ageValue.toInt().toString(),
    );
  }

  Future<void> selectGender() async {
    if (gender == Gender.none.name || gender == Gender.male.name) {
      gender = Gender.female.name;
      genderInput.controller.text = LocaleKeys.auth_register_woman.tr();
    } else if (gender == Gender.female.name) {
      gender = Gender.male.name;
      genderInput.controller.text = LocaleKeys.auth_register_man.tr();
    }
    await HiveManager.save(
      key: BoxKeyNames.gender.name,
      value: gender == Gender.female.name
          ? ServiceConstants.female
          : ServiceConstants.male,
    );
  }

  Future<void> selectCountry(int index) async {
    countries[index].name ?? AppStrings.empty;
    await HiveManager.save(
      key: BoxKeyNames.country.name,
      value: countries[index].name ?? AppStrings.empty,
    );
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
      loading.changeLoading();
      final response =
          await AuthService().addPhoto(file: File(pickedFile.path));
      loading.changeLoading();
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
      loading.changeLoading();
      final response = await AuthService().updatePhoto(
        file: File(pickedFile.path),
        photoId: photoId,
      );
      loading.changeLoading();
      await getMe();
      return response;
    }
    return ResponseModel();
  }

  Future<ResponseModel> deletePhoto({
    required String photoId,
  }) async {
    loading.changeLoading();
    final response = await AuthService().deletePhoto(photoId: photoId);
    loading.changeLoading();
    await getMe();
    return response;
  }
}
