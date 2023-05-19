// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeViewModel on _HomeViewModelBase, Store {
  late final _$progressValueAtom =
      Atom(name: '_HomeViewModelBase.progressValue', context: context);

  @override
  double get progressValue {
    _$progressValueAtom.reportRead();
    return super.progressValue;
  }

  @override
  set progressValue(double value) {
    _$progressValueAtom.reportWrite(value, super.progressValue, () {
      super.progressValue = value;
    });
  }

  @override
  String toString() {
    return '''
progressValue: ${progressValue}
    ''';
  }
}
