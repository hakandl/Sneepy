import 'package:mobx/mobx.dart';
import 'package:sneepy/product/models/user_model.dart';
import 'package:sneepy/product/services/auth_service.dart';
part 'friends_viewmodel.g.dart';

class FriendsViewModel = _FriendsViewModelBase with _$FriendsViewModel;

abstract class _FriendsViewModelBase with Store {
  @observable
  bool isLoading = false;

  @action
  void changeLoading() {
    isLoading = !isLoading;
  }

  UserModel? user;

  Future<void> getUser() async {
    changeLoading();
    user = await AuthService().getMe();
    changeLoading();
  }
}
