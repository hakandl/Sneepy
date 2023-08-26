// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SettingsViewModel on _SettingsViewModelBase, Store {
  late final _$isLoadingAtom =
      Atom(name: '_SettingsViewModelBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$ageValueAtom =
      Atom(name: '_SettingsViewModelBase.ageValue', context: context);

  @override
  double get ageValue {
    _$ageValueAtom.reportRead();
    return super.ageValue;
  }

  @override
  set ageValue(double value) {
    _$ageValueAtom.reportWrite(value, super.ageValue, () {
      super.ageValue = value;
    });
  }

  late final _$_SettingsViewModelBaseActionController =
      ActionController(name: '_SettingsViewModelBase', context: context);

  @override
  void changeLoading() {
    final _$actionInfo = _$_SettingsViewModelBaseActionController.startAction(
        name: '_SettingsViewModelBase.changeLoading');
    try {
      return super.changeLoading();
    } finally {
      _$_SettingsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
ageValue: ${ageValue}
    ''';
  }
}
