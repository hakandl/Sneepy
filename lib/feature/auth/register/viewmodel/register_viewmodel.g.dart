// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RegisterViewModel on _RegisterViewModelBase, Store {
  late final _$screenModeAtom =
      Atom(name: '_RegisterViewModelBase.screenMode', context: context);

  @override
  int get screenMode {
    _$screenModeAtom.reportRead();
    return super.screenMode;
  }

  @override
  set screenMode(int value) {
    _$screenModeAtom.reportWrite(value, super.screenMode, () {
      super.screenMode = value;
    });
  }

  late final _$registerProgressValueAtom = Atom(
      name: '_RegisterViewModelBase.registerProgressValue', context: context);

  @override
  double get registerProgressValue {
    _$registerProgressValueAtom.reportRead();
    return super.registerProgressValue;
  }

  @override
  set registerProgressValue(double value) {
    _$registerProgressValueAtom.reportWrite(value, super.registerProgressValue,
        () {
      super.registerProgressValue = value;
    });
  }

  late final _$imageAtom =
      Atom(name: '_RegisterViewModelBase.image', context: context);

  @override
  File? get image {
    _$imageAtom.reportRead();
    return super.image;
  }

  @override
  set image(File? value) {
    _$imageAtom.reportWrite(value, super.image, () {
      super.image = value;
    });
  }

  late final _$_RegisterViewModelBaseActionController =
      ActionController(name: '_RegisterViewModelBase', context: context);

  @override
  void nextRegisterInfo() {
    final _$actionInfo = _$_RegisterViewModelBaseActionController.startAction(
        name: '_RegisterViewModelBase.nextRegisterInfo');
    try {
      return super.nextRegisterInfo();
    } finally {
      _$_RegisterViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void backRegisterInfo() {
    final _$actionInfo = _$_RegisterViewModelBaseActionController.startAction(
        name: '_RegisterViewModelBase.backRegisterInfo');
    try {
      return super.backRegisterInfo();
    } finally {
      _$_RegisterViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setImage(File? image) {
    final _$actionInfo = _$_RegisterViewModelBaseActionController.startAction(
        name: '_RegisterViewModelBase.setImage');
    try {
      return super.setImage(image);
    } finally {
      _$_RegisterViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
screenMode: ${screenMode},
registerProgressValue: ${registerProgressValue},
image: ${image}
    ''';
  }
}
