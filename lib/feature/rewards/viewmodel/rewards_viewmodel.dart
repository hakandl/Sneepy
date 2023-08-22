import 'package:mobx/mobx.dart';
import 'package:sneepy/product/models/response_model.dart';
import 'package:sneepy/product/models/user_model.dart';
import 'package:sneepy/product/services/auth_service.dart';
import 'package:sneepy/product/services/user_service.dart';
part 'rewards_viewmodel.g.dart';

class RewardsViewModel = _RewardsViewModelBase with _$RewardsViewModel;

abstract class _RewardsViewModelBase with Store {
  @observable
  bool isLoading = false;

  @action
  void changeLoading() {
    isLoading = !isLoading;
  }

  UserModel? me;

  Future<void> getMe() async {
    changeLoading();
    me = await AuthService().getMe();
    changeLoading();
  }

  Future<ResponseModel> addPoint() async {
    changeLoading();
    final response = await UserService().addPoint();
    changeLoading();
    return response;
  }
}
