// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friends_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FriendsViewModel on _FriendsViewModelBase, Store {
  late final _$isLoadingAtom =
      Atom(name: '_FriendsViewModelBase.isLoading', context: context);

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

  late final _$_FriendsViewModelBaseActionController =
      ActionController(name: '_FriendsViewModelBase', context: context);

  @override
  void changeLoading() {
    final _$actionInfo = _$_FriendsViewModelBaseActionController.startAction(
        name: '_FriendsViewModelBase.changeLoading');
    try {
      return super.changeLoading();
    } finally {
      _$_FriendsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading}
    ''';
  }
}
