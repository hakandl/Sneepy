import 'package:mobx/mobx.dart';
import 'package:sneepy/product/models/user_model.dart';
import 'package:sneepy/product/services/auth_service.dart';
import 'package:sneepy/product/services/user_service.dart';
part 'home_viewmodel.g.dart';

class HomeViewModel = _HomeViewModelBase with _$HomeViewModel;

abstract class _HomeViewModelBase with Store {
  UserModel? me;

  List<UserModel> users = [];

  @observable
  double progressValue = 0.3;

  @observable
  bool isLoading = false;

  @action
  void changeLoading() {
    isLoading = !isLoading;
  }

  Future<void> getMe() async {
    changeLoading();
    me = await AuthService().getMe();
    changeLoading();
  }

  Future<void> getUsers() async {
    changeLoading();
    users = await UserService().getUsers();
    changeLoading();
  }
}
