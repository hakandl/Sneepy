import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kartal/kartal.dart';
import 'package:sneepy/feature/rewards/viewmodel/rewards_viewmodel.dart';
import 'package:sneepy/product/constants/strings.dart';
import 'package:sneepy/product/helpers/date.dart';
import 'package:sneepy/product/init/language/locale_keys.g.dart';
import 'package:sneepy/product/widgets/card/select_card.dart';
import 'package:sneepy/product/widgets/container/standart_container.dart';
import 'package:sneepy/product/widgets/dialog/standart_dialog.dart';
import 'package:sneepy/product/widgets/text/title_medium_text.dart';

class RewardsView extends StatefulWidget {
  const RewardsView({super.key});

  @override
  State<RewardsView> createState() => _RewardsViewState();
}

class _RewardsViewState extends State<RewardsView> {
  final RewardsViewModel vm = RewardsViewModel();

  @override
  void initState() {
    super.initState();
    getMe();
  }

  Future<void> getMe() async {
    await vm.getMe();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.rewards_rewards.tr()),
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
                        SelectCard(
                          title: TitleMediumText(
                            text: LocaleKeys.rewards_gift100Points.tr(),
                          ),
                          onTap: () async {
                            final response = await vm.addPoint();
                            if (response.success == true) {
                              Fluttertoast.showToast(
                                msg: LocaleKeys
                                    .rewards_100GiftPointsAddedToYourAccount
                                    .tr(),
                              );
                            } else if (response.success == false) {
                              if (context.mounted) {
                                showStandartDialog(
                                  context,
                                  title: LocaleKeys.thereIsProblem.tr(),
                                  content: Text(
                                    response.message ?? AppStrings.empty,
                                  ),
                                );
                              }
                            }
                          },
                        ),
                        Observer(
                          builder: (_) {
                            return vm.isLoading
                                ? const CircularProgressIndicator()
                                : vm.me?.isFreePoint == false
                                    ? Column(
                                        children: [
                                          context.emptySizedHeightBoxLow,
                                          Padding(
                                            padding:
                                                context.horizontalPaddingLow,
                                            child: TitleMediumText(
                                                text:
                                                    '${LocaleKeys.rewards_youCannotReceiveNewGiftPointsBeforeThisDate.tr()} ${vm.me?.pointTimeToScore.convertDateString()}'),
                                          ),
                                        ],
                                      )
                                    : const SizedBox.shrink();
                          },
                        )
                      ],
                    ),
                  ),
                  context.emptySizedHeightBoxNormal,
                  StandartContainer(
                    child: Column(
                      children: [
                        SelectCard(
                          title: TitleMediumText(
                            text: LocaleKeys.rewards_gift100Points.tr(),
                          ),
                        ),
                        const Divider(),
                        SelectCard(
                          title: TitleMediumText(
                            text: LocaleKeys.rewards_gift100Points.tr(),
                          ),
                        ),
                        const Divider(),
                        SelectCard(
                          title: TitleMediumText(
                            text: LocaleKeys.rewards_gift100Points.tr(),
                          ),
                        ),
                        const Divider(),
                        SelectCard(
                          title: TitleMediumText(
                            text: LocaleKeys.rewards_gift100Points.tr(),
                          ),
                        ),
                        const Divider(),
                        SelectCard(
                          title: TitleMediumText(
                            text: LocaleKeys.rewards_gift100Points.tr(),
                          ),
                        ),
                        const Divider(),
                        SelectCard(
                          title: TitleMediumText(
                            text: LocaleKeys.rewards_gift100Points.tr(),
                          ),
                        ),
                        const Divider(),
                        SelectCard(
                          title: TitleMediumText(
                            text: LocaleKeys.rewards_gift100Points.tr(),
                          ),
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
