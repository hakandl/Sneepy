// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginViewModel on _LoginViewModelBase, Store {
  late final _$isShowPasswordAtom =
      Atom(name: '_LoginViewModelBase.isShowPassword', context: context);

  @override
  bool get isShowPassword {
    _$isShowPasswordAtom.reportRead();
    return super.isShowPassword;
  }

  @override
  set isShowPassword(bool value) {
    _$isShowPasswordAtom.reportWrite(value, super.isShowPassword, () {
      super.isShowPassword = value;
    });
  }

  late final _$_LoginViewModelBaseActionController =
      ActionController(name: '_LoginViewModelBase', context: context);

  @override
  void showPassword() {
    final _$actionInfo = _$_LoginViewModelBaseActionController.startAction(
        name: '_LoginViewModelBase.showPassword');
    try {
      return super.showPassword();
    } finally {
      _$_LoginViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isShowPassword: ${isShowPassword}
    ''';
  }
}
