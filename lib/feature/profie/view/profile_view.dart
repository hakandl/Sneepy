import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:sneepy/feature/profie/settings/view/profile_settings_view.dart';
import 'package:sneepy/product/widgets/container/standart_container.dart';
import 'package:sneepy/product/widgets/input/standart_textfield.dart';
import 'package:sneepy/product/widgets/text/headline_medium_text.dart';
import 'package:sneepy/product/widgets/text/title_large_text.dart';
import 'package:sneepy/product/widgets/text/title_medium_text.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('data'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              context.navigateToPage(const ProfileSettingsView());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          context.emptySizedHeightBoxLow3x,
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  StandartContainer(
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 48,
                          backgroundImage: NetworkImage(
                            'https://media.gettyimages.com/id/1347431090/photo/fit-woman-standing-outdoors-after-a-late-afternoon-trail-run.jpg?s=612x612&w=gi&k=20&c=H9W6QxJoLP607i_BE7kT-VtxNGtaT7E6U4XIn03IHLg=',
                          ),
                        ),
                        context.emptySizedWidthBoxNormal,
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HeadlineMediumText(text: 'text'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  context.emptySizedHeightBoxNormal,
                  StandartContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TitleLargeText(text: 'Bazı Bilgiler'),
                        context.emptySizedHeightBoxLow3x,
                        const TitleMediumText(text: 'Yaş'),
                        context.emptySizedHeightBoxLow,
                        StandartTextField(
                          text: 'text',
                          prefix: const Icon(FontAwesomeIcons.arrowUp19),
                          enabled: false,
                        ),
                        context.emptySizedHeightBoxLow3x,
                        const TitleMediumText(text: 'Cinsiyet'),
                        context.emptySizedHeightBoxLow,
                        StandartTextField(
                          text: 'text',
                          prefix: const Icon(FontAwesomeIcons.marsAndVenus),
                          enabled: false,
                        ),
                        context.emptySizedHeightBoxLow3x,
                        const TitleMediumText(text: 'Email'),
                        context.emptySizedHeightBoxLow,
                        StandartTextField(
                          text: 'text',
                          prefix: const Icon(FontAwesomeIcons.envelope),
                          enabled: false,
                        ),
                      ],
                    ),
                  ),
                  context.emptySizedHeightBoxNormal,
                  StandartContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TitleLargeText(text: 'Sosyal Hesaplar'),
                        context.emptySizedHeightBoxLow3x,
                        const TitleMediumText(text: 'Snapchat'),
                        context.emptySizedHeightBoxLow,
                        StandartTextField(
                          text: 'text',
                          prefix: const Icon(FontAwesomeIcons.snapchat),
                          enabled: false,
                        ),
                        context.emptySizedHeightBoxLow3x,
                        const TitleMediumText(text: 'Instagram'),
                        context.emptySizedHeightBoxLow,
                        StandartTextField(
                          text: 'text',
                          prefix: const Icon(FontAwesomeIcons.instagram),
                          enabled: false,
                        ),
                        context.emptySizedHeightBoxLow3x,
                        const TitleMediumText(text: 'Twitter'),
                        context.emptySizedHeightBoxLow,
                        StandartTextField(
                          text: 'text',
                          prefix: const Icon(FontAwesomeIcons.twitter),
                          enabled: false,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          context.emptySizedHeightBoxLow3x,
        ],
      ),
    );
  }
}
