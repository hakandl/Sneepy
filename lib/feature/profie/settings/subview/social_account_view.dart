import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:sneepy/product/widgets/container/standart_container.dart';
import 'package:sneepy/product/widgets/input/standart_textfield.dart';
import 'package:sneepy/product/widgets/text/title_medium_text.dart';

import '../../../../product/widgets/button/standart_text_button.dart';

class SocialAccountView extends StatelessWidget {
  const SocialAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sosyal Hesaplar'),
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
                    const TitleMediumText(text: 'Snapchat'),
                    context.emptySizedHeightBoxLow,
                    StandartTextField(
                      text: 'text',
                      prefix: Icon(FontAwesomeIcons.snapchat),
                    ),
                    context.emptySizedHeightBoxLow3x,
                    const TitleMediumText(text: 'Instagram'),
                    context.emptySizedHeightBoxLow,
                    StandartTextField(
                      text: 'text',
                      prefix: Icon(FontAwesomeIcons.instagram),
                    ),
                    context.emptySizedHeightBoxLow3x,
                    const TitleMediumText(text: 'Twitter'),
                    context.emptySizedHeightBoxLow,
                    StandartTextField(
                      text: 'text',
                      prefix: Icon(FontAwesomeIcons.twitter),
                    ),
                    context.emptySizedHeightBoxLow3x,
                    StandartTextButton(
                      text: 'text',
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
          context.emptySizedHeightBoxLow3x,
        ],
      ),
    );
  }
}
