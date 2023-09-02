import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kartal/kartal.dart';
import 'package:sneepy/feature/home/view/home_view.dart';
import 'package:sneepy/feature/rewards/viewmodel/rewards_viewmodel.dart';
import 'package:sneepy/product/constants/enums/number.dart';
import 'package:sneepy/product/constants/strings.dart';
import 'package:sneepy/product/init/language/locale_keys.g.dart';
import 'package:sneepy/product/widgets/card/select_card.dart';
import 'package:sneepy/product/widgets/container/standart_container.dart';
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
    init();
  }

  Future<void> init() async {
    await vm.init();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.navigateToPage(
          const HomeView(),
        );
        return false;
      },
      child: Scaffold(
        appBar: _appBar(),
        body: Observer(
          builder: (_) {
            return vm.loading.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      context.emptySizedHeightBoxLow3x,
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              RewardsGiftContainer(vm: vm),
                              context.emptySizedHeightBoxNormal,
                              RewardedAdContainer(vm: vm),
                              context.emptySizedHeightBoxNormal,
                              PackagesContainer(vm: vm),
                            ],
                          ),
                        ),
                      ),
                      context.emptySizedHeightBoxLow3x,
                    ],
                  );
          },
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        LocaleKeys.rewards_rewards.tr(),
      ),
    );
  }
}

class RewardsGiftContainer extends StatelessWidget {
  const RewardsGiftContainer({
    super.key,
    required this.vm,
  });

  final RewardsViewModel vm;

  @override
  Widget build(BuildContext context) {
    return StandartContainer(
      child: SelectCard(
        title: TitleMediumText(
          text: LocaleKeys.rewards_gift100Points.tr(),
        ),
        onTap: () async {
          final response = await vm.addPoint();
          if (response.success == true) {
            Fluttertoast.showToast(
              msg: response.message ?? AppStrings.empty,
            );
          } else if (response.success == false) {
            Fluttertoast.showToast(
              msg: response.message ?? AppStrings.empty,
            );
          }
        },
      ),
    );
  }
}

class RewardedAdContainer extends StatelessWidget {
  const RewardedAdContainer({
    super.key,
    required this.vm,
  });

  final RewardsViewModel vm;

  @override
  Widget build(BuildContext context) {
    return StandartContainer(
      child: SelectCard(
        title: TitleMediumText(
          text: LocaleKeys.rewards_watchAnAdAndGet100PointsForFree.tr(),
        ),
        onTap: () {
          vm.showRewardedAd();
        },
      ),
    );
  }
}

class PackagesContainer extends StatelessWidget {
  const PackagesContainer({
    super.key,
    required this.vm,
  });

  final RewardsViewModel vm;

  @override
  Widget build(BuildContext context) {
    return StandartContainer(
      child: ListView.builder(
        itemCount: vm.packages?.length ?? NumberEnum.zero.value.toInt(),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          final currentProduct = vm.packages?[index].storeProduct;
          return SelectCard(
            leading: TitleMediumText(
              text: currentProduct?.priceString ?? AppStrings.empty,
            ),
            title: TitleMediumText(
              text: currentProduct?.title ?? AppStrings.empty,
            ),
            subtitle: TitleMediumText(
              text: currentProduct?.description ?? AppStrings.empty,
            ),
            onTap: () async {
              await vm.productPurchase(
                vm.packages![index],
              );
            },
          );
        },
      ),
    );
  }
}
