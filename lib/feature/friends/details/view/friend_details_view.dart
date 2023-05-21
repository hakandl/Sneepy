import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:sneepy/product/widgets/card/friend_card.dart';

class FriendDetailsView extends StatelessWidget {
  const FriendDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('data'),
      ),
      body: SafeArea(
        child: Padding(
          padding: context.paddingLow,
          child: FriendCard(),
        ),
      ),
    );
  }
}
