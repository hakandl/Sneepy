import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';
import 'package:sneepy/feature/friends/viewmodel/friends_viewmodel.dart';
import 'package:sneepy/product/constants/strings.dart';
import 'package:sneepy/product/models/user_model.dart';
import 'package:sneepy/product/widgets/card/friend_card.dart';

class FriendDetailsView extends StatefulWidget {
  const FriendDetailsView({super.key, required this.id});
  final String id;

  @override
  State<FriendDetailsView> createState() => _FriendDetailsViewState();
}

class _FriendDetailsViewState extends State<FriendDetailsView> {
  final FriendsViewModel vm = FriendsViewModel();

  @override
  void initState() {
    super.initState();
    getUser();
  }

  Future<void> getUser() async {
    await vm.getFriendUser(userId: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SafeArea(
        child: Padding(
          padding: context.paddingLow,
          child: Observer(builder: (_) {
            return vm.isLoading
                ? const Center(child: CircularProgressIndicator())
                : FriendCard(
                    user: vm.friendUser ?? UserModel(),
                  );
          }),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Observer(builder: (_) {
        return Text(
          vm.friendUser?.name ?? AppStrings.empty,
        );
      }),
    );
  }
}
