// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SettingsViewModel on _SettingsViewModelBase, Store {
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

  @override
  String toString() {
    return '''
ageValue: ${ageValue}
    ''';
  }
}
