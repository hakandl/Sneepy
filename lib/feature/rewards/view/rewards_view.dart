import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:sneepy/product/widgets/card/select_card.dart';
import 'package:sneepy/product/widgets/container/standart_container.dart';
import 'package:sneepy/product/widgets/text/title_large_text.dart';

class RewardsView extends StatelessWidget {
  const RewardsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ödül'),
      ),
      body: Column(
        children: [
          context.emptySizedHeightBoxLow3x,
          Flexible(
            child: StandartContainer(
                child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TitleLargeText(
                    text: 'LocaleKeys',
                  ),
                  context.emptySizedHeightBoxLow,
                  const SelectCard(
                    title: Text('reklam'),
                  ),
                  const Divider(),
                  context.emptySizedHeightBoxLow3x,
                  const TitleLargeText(
                    text: 'LocaleKeys',
                  ),
                  context.emptySizedHeightBoxLow,
                  const SelectCard(
                    title: Text('reklam'),
                  ),
                  const Divider(),
                  const SelectCard(
                    title: Text('reklam'),
                  ),
                  const Divider(),
                  const SelectCard(
                    title: Text('reklam'),
                  ),
                  const Divider(),
                  const SelectCard(
                    title: Text('reklam'),
                  ),
                  const Divider(),
                  const SelectCard(
                    title: Text('reklam'),
                  ),
                  const Divider(),
                  const SelectCard(
                    title: Text('reklam'),
                  ),
                  const Divider(),
                ],
              ),
            )),
          ),
          context.emptySizedHeightBoxLow3x,
        ],
      ),
    );
  }
}
