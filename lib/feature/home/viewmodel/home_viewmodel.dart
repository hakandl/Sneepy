import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:sneepy/product/cache/hive_manager.dart';
import 'package:sneepy/product/constants/enums/number.dart';
import 'package:sneepy/product/models/response_model.dart';
import 'package:sneepy/product/models/user_model.dart';
import 'package:sneepy/product/services/auth_service.dart';
import 'package:sneepy/product/services/user_service.dart';
import 'package:sneepy/product/utils/loading.dart';
part 'home_viewmodel.g.dart';

class HomeViewModel = _HomeViewModelBase with _$HomeViewModel;

abstract class _HomeViewModelBase with Store {
  final LoadingUtil loading = LoadingUtil();

  final GlobalKey profileKey = GlobalKey();
  final GlobalKey pointKey = GlobalKey();
  final GlobalKey friendRequestKey = GlobalKey();
  final GlobalKey userCardKey = GlobalKey();
  final GlobalKey skipFriendRequestKey = GlobalKey();
  final GlobalKey sendFriendRequestKey = GlobalKey();
  final GlobalKey sendStarFriendRequestKey = GlobalKey();

  @observable
  UserModel? me;

  List<UserModel> users = [];

  UserModel? currentUser;

  Future<void> firstShowCase(BuildContext context) async {
    bool isFirstLaunch =
        HiveManager.get(key: BoxKeyNames.showcase.name) ?? true;
    if (isFirstLaunch == true) {
      ShowCaseWidget.of(context).startShowCase([
        profileKey,
        pointKey,
        friendRequestKey,
        userCardKey,
        skipFriendRequestKey,
        sendFriendRequestKey,
        sendStarFriendRequestKey,
      ]);
      await HiveManager.save(key: BoxKeyNames.showcase.name, value: false);
    } else {
      ShowCaseWidget.of(context).dismiss();
    }
  }

  @observable
  double progressValue = NumberEnum.zThree.value;

  void changeUser(PageController pageController) {
    pageController.jumpToPage(
        pageController.page!.toInt() + NumberEnum.one.value.toInt());
  }

  Future<void> getMe() async {
    loading.changeLoading();
    me = await AuthService().getMe();
    loading.changeLoading();
  }

  Future<void> getUsers() async {
    loading.changeLoading();
    users = await UserService().getUsers();
    loading.changeLoading();
  }

  Future<ResponseModel> sendFriendRequest({
    required String userId,
    required int sentType,
    required PageController pageController,
  }) async {
    final response = await UserService().sendFriendRequest(
      userId: userId,
      sentType: sentType,
    );
    if (response.success == true) {
      changeUser(pageController);
      me = await AuthService().getMe();
    }
    return response;
  }

  Future<ResponseModel> skipFriendRequest({
    required String userId,
    required PageController pageController,
  }) async {
    final response = await UserService().skipFriendRequest(
      userId: userId,
    );
    if (response.success == true) {
      changeUser(pageController);
    }
    return response;
  }
}
