import 'package:mobx/mobx.dart';
import 'package:sneepy/product/constants/enums/number.dart';
import 'package:sneepy/product/models/user_model.dart';
import 'package:sneepy/product/services/auth_service.dart';
import 'package:sneepy/product/services/user_service.dart';
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

  @observable
  UserModel? friendUser;

  Future<void> getUser() async {
    changeLoading();
    user = await AuthService().getMe();
    changeLoading();
  }

  Future<void> getFriendUser({required String userId}) async {
    changeLoading();
    friendUser = await UserService().getUser(
      userId: userId,
    );
    changeLoading();
  }

  Future<void> deleteFriendRequest({required String userId}) async {
    await UserService().removeFriendRequest(
      userId: userId,
    );
    await getUser();
  }

  Future<void> acceptFriendRequest({required String userId}) async {
    await UserService().sendFriendRequest(
      userId: userId,
      sentType: NumberEnum.two.value.toInt(),
    );
    await deleteFriendRequest(userId: userId);
  }
}
