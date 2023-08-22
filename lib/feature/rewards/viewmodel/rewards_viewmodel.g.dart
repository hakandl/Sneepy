// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rewards_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RewardsViewModel on _RewardsViewModelBase, Store {
  late final _$isLoadingAtom =
      Atom(name: '_RewardsViewModelBase.isLoading', context: context);

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

  late final _$_RewardsViewModelBaseActionController =
      ActionController(name: '_RewardsViewModelBase', context: context);

  @override
  void changeLoading() {
    final _$actionInfo = _$_RewardsViewModelBaseActionController.startAction(
        name: '_RewardsViewModelBase.changeLoading');
    try {
      return super.changeLoading();
    } finally {
      _$_RewardsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading}
    ''';
  }
}
