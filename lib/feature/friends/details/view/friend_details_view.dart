import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:sneepy/product/constants/strings.dart';
import 'package:sneepy/product/models/user_model.dart';
import 'package:sneepy/product/widgets/card/friend_card.dart';

class FriendDetailsView extends StatelessWidget {
  const FriendDetailsView({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SafeArea(
        child: Padding(
          padding: context.paddingLow,
          child: FriendCard(
            user: user,
          ),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        user.name ?? AppStrings.empty,
      ),
    );
  }
}
