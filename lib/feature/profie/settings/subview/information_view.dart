import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:sneepy/product/widgets/container/standart_container.dart';
import 'package:sneepy/product/widgets/input/standart_textfield.dart';
import 'package:sneepy/product/widgets/text/title_medium_text.dart';

import '../../../../product/widgets/button/standart_text_button.dart';

class InformationView extends StatelessWidget {
  const InformationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bazı Bilgiler'),
      ),
      body: Column(
        children: [
          context.emptySizedHeightBoxLow3x,
          StandartContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TitleMediumText(text: 'İsim'),
                context.emptySizedHeightBoxLow,
                StandartTextField(
                  text: 'text',
                  prefix: const Icon(FontAwesomeIcons.user),
                ),
                context.emptySizedHeightBoxLow3x,
                const TitleMediumText(text: 'Yaş'),
                context.emptySizedHeightBoxLow,
                StandartTextField(
                  text: 'text',
                  prefix: const Icon(FontAwesomeIcons.arrowUp19),
                ),
                context.emptySizedHeightBoxLow3x,
                StandartTextButton(
                  text: 'text',
                  onPressed: () {},
                ),
              ],
            ),
          ),
          context.emptySizedHeightBoxLow3x,
        ],
      ),
    );
  }
}
