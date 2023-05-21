import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:sneepy/feature/profie/settings/subview/information_view.dart';
import 'package:sneepy/feature/profie/settings/subview/photos_view.dart';
import 'package:sneepy/feature/profie/settings/subview/social_account_view.dart';
import 'package:sneepy/product/widgets/container/standart_container.dart';
import 'package:sneepy/product/widgets/text/title_medium_text.dart';

class ProfileSettingsView extends StatelessWidget {
  const ProfileSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('data'),
      ),
      body: Column(
        children: [
          context.emptySizedHeightBoxLow3x,
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  StandartContainer(
                    child: Column(
                      children: [
                        SettingsListTile(
                          text: 'text',
                          onTap: () {
                            context.navigateToPage(const InformationView());
                          },
                        ),
                        const Divider(),
                        SettingsListTile(
                          text: 'text',
                          onTap: () {
                            context.navigateToPage(const SocialAccountView());
                          },
                        ),
                        const Divider(),
                        SettingsListTile(
                          text: 'text',
                          onTap: () {
                            context.navigateToPage(PhotosView());
                          },
                        ),
                      ],
                    ),
                  ),
                  context.emptySizedHeightBoxNormal,
                  StandartContainer(
                    child: Column(
                      children: [
                        SettingsListTile(
                          text: 'text',
                          onTap: () {},
                        ),
                        const Divider(),
                        SettingsListTile(
                          text: 'text',
                          onTap: () {
                            showLicensePage(context: context);
                          },
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

class SettingsListTile extends StatelessWidget {
  const SettingsListTile({
    super.key,
    required this.text,
    required this.onTap,
  });
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      title: TitleMediumText(text: text),
      trailing: const Icon(Icons.arrow_forward_outlined),
      onTap: onTap,
    );
  }
}
