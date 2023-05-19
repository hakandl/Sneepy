import 'dart:io';

import 'package:mobx/mobx.dart';
part 'register_viewmodel.g.dart';

class RegisterViewModel = _RegisterViewModelBase with _$RegisterViewModel;

abstract class _RegisterViewModelBase with Store {
  @observable
  int screenMode = 1;

  @observable
  double registerProgressVaue = 0.33;

  @observable
  ObservableList<File?> images = ObservableList<File?>.of([null, null, null]);

  @action
  void nextRegisterInfo() {
    screenMode++;
    registerProgressVaue += 0.33;
    if (screenMode == 3) {
      registerProgressVaue = 1;
    }
    print(registerProgressVaue);
  }

  @action
  void backRegisterInfo() {
    screenMode--;
    registerProgressVaue -= 0.33;
    print(registerProgressVaue);
  }

  @action
  void setImage(int index, File? image) {
    images[index] = image;
  }
}
