// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loading.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoadingUtil on _LoadingUtilBase, Store {
  late final _$isLoadingAtom =
      Atom(name: '_LoadingUtilBase.isLoading', context: context);

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

  late final _$_LoadingUtilBaseActionController =
      ActionController(name: '_LoadingUtilBase', context: context);

  @override
  void changeLoading() {
    final _$actionInfo = _$_LoadingUtilBaseActionController.startAction(
        name: '_LoadingUtilBase.changeLoading');
    try {
      return super.changeLoading();
    } finally {
      _$_LoadingUtilBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading}
    ''';
  }
}
