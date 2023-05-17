import 'package:mobx/mobx.dart';
part 'login_viewmodel.g.dart';

class LoginViewModel = _LoginViewModelBase with _$LoginViewModel;

abstract class _LoginViewModelBase with Store {
  @observable
  bool isShowPassword = true;

  @action
  void showPassword() {
    isShowPassword = !isShowPassword;
  }
}
