import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mobx/mobx.dart';
import 'package:purchases_flutter/errors.dart';
import 'package:purchases_flutter/models/package_wrapper.dart';
import 'package:purchases_flutter/purchases_flutter.dart' as purchase;
import 'package:sneepy/product/constants/enums/number.dart';
import 'package:sneepy/product/constants/enums/point.dart';
import 'package:sneepy/product/constants/service.dart';
import 'package:sneepy/product/init/language/locale_keys.g.dart';
import 'package:sneepy/product/models/response_model.dart';
import 'package:sneepy/product/models/user_model.dart';
import 'package:sneepy/product/services/auth_service.dart';
import 'package:sneepy/product/services/user_service.dart';
import 'package:sneepy/product/utils/loading.dart';

import '../../../product/services/revenuecat_service.dart';
part 'rewards_viewmodel.g.dart';

class RewardsViewModel = _RewardsViewModelBase with _$RewardsViewModel;

abstract class _RewardsViewModelBase with Store {
  final LoadingUtil loading = LoadingUtil();
  RewardedAd? rewardedAd;
  List<Package>? packages;
  UserModel? me;

  Future<void> init() async {
    await getMe();
    await getOffers();
    await initGoogleMobileAds();
    initRewardedAd();
  }

  Future<InitializationStatus> initGoogleMobileAds() {
    return MobileAds.instance.initialize();
  }

  Future<void> getMe() async {
    loading.changeLoading();
    me = await AuthService().getMe();
    loading.changeLoading();
  }

  Future<ResponseModel> addPoint() async {
    loading.changeLoading();
    final response = await UserService().addPoint();
    loading.changeLoading();
    return response;
  }

  void initRewardedAd() {
    RewardedAd.load(
        adUnitId: ServiceConstants.adUnitId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (ad) {
            ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdDismissedFullScreenContent: (ad) async {
                ad.dispose();
                rewardedAd = null;
                initRewardedAd();
                await updatePoint(point: NumberEnum.oneHundred.value.toInt());
                Fluttertoast.showToast(
                  msg: LocaleKeys.rewards_100GiftPointsAddedToYourAccount.tr(),
                );
              },
            );
            rewardedAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            Fluttertoast.showToast(
              msg: LocaleKeys.rewards_thereWasAnErrorLoadingTheAd.tr(),
            );
          },
        ));
  }

  void showRewardedAd() {
    rewardedAd?.show(
      onUserEarnedReward: (ad, reward) {},
    );
  }

  Future<void> getOffers() async {
    loading.changeLoading();
    final offerings = await RevenueCatService.getOffers();
    packages = offerings
        .map((offer) => offer.availablePackages)
        .expand((pair) => pair)
        .toList();
    loading.changeLoading();
  }

  Future<void> productPurchase(Package package) async {
    try {
      purchase.CustomerInfo purchaserInfo =
          await purchase.Purchases.purchasePackage(package);
      if (purchaserInfo
          .entitlements.all["my_entitlement_identifier"]!.isActive) {
        int? point;
        if (package.offeringIdentifier ==
            PointOfferingIdentifier.point250.name) {
          point = NumberEnum.twoHundredFifty.value.toInt();
        } else if (package.offeringIdentifier ==
            PointOfferingIdentifier.point500.name) {
          point = NumberEnum.fiveHundred.value.toInt();
        } else if (package.offeringIdentifier ==
            PointOfferingIdentifier.point1000.name) {
          point = NumberEnum.oneThousand.value.toInt();
        } else if (package.offeringIdentifier ==
            PointOfferingIdentifier.point2500.name) {
          point = NumberEnum.twoThousandFiveHundred.value.toInt();
        } else if (package.offeringIdentifier ==
            PointOfferingIdentifier.point5000.name) {
          point = NumberEnum.fiveThousand.value.toInt();
        } else if (package.offeringIdentifier ==
            PointOfferingIdentifier.point7500.name) {
          point = NumberEnum.sevenThousandFiveHundred.value.toInt();
        } else if (package.offeringIdentifier ==
            PointOfferingIdentifier.point10000.name) {
          point = NumberEnum.tenThousand.value.toInt();
        }
        await updatePoint(point: point ?? NumberEnum.zero.value.toInt());
        Fluttertoast.showToast(
          msg:
              LocaleKeys.rewards_paymentSuccessfulPointsAddedToYourAccount.tr(),
        );
      }
    } on PlatformException catch (e) {
      var errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
        Fluttertoast.showToast(
          msg: LocaleKeys.rewards_paymentFailed.tr(),
        );
      }
    }
  }

  Future<void> updatePoint({required int point}) async {
    loading.changeLoading();
    await UserService().updatePoint(point: point);
    loading.changeLoading();
  }
}
