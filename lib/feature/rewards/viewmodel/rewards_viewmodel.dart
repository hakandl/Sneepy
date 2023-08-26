import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';
import 'package:purchases_flutter/errors.dart';
import 'package:purchases_flutter/models/package_wrapper.dart';
import 'package:purchases_flutter/purchases_flutter.dart' as purchase;
import 'package:sneepy/product/constants/enums/number.dart';
import 'package:sneepy/product/constants/enums/point.dart';
import 'package:sneepy/product/init/language/locale_keys.g.dart';
import 'package:sneepy/product/models/response_model.dart';
import 'package:sneepy/product/models/user_model.dart';
import 'package:sneepy/product/services/auth_service.dart';
import 'package:sneepy/product/services/user_service.dart';
import 'package:sneepy/product/widgets/dialog/standart_dialog.dart';

import '../../../product/services/revenuecat_service.dart';
part 'rewards_viewmodel.g.dart';

class RewardsViewModel = _RewardsViewModelBase with _$RewardsViewModel;

abstract class _RewardsViewModelBase with Store {
  @observable
  bool isLoading = false;

  @action
  void changeLoading() {
    isLoading = !isLoading;
  }

  List<Package>? packages;

  UserModel? me;

  Future<void> getMe() async {
    changeLoading();
    me = await AuthService().getMe();
    changeLoading();
  }

  Future<ResponseModel> addPoint() async {
    changeLoading();
    final response = await UserService().addPoint();
    changeLoading();
    return response;
  }

  Future<void> getOffers() async {
    changeLoading();
    final offerings = await RevenueCatService.getOffers();
    packages = offerings
        .map((offer) => offer.availablePackages)
        .expand((pair) => pair)
        .toList();
    changeLoading();
  }

  Future<void> prodPurchase(Package package, BuildContext context) async {
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
        if (context.mounted) {
          showStandartDialog(
            context,
            title: LocaleKeys.successful.tr(),
            content: Text(
              LocaleKeys.rewards_paymentSuccessfulPointsAddedToYourAccount.tr(),
            ),
          );
        }
      }
    } on PlatformException catch (e) {
      var errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
        showStandartDialog(
          context,
          title: LocaleKeys.thereIsProblem.tr(),
          content: Text(
            LocaleKeys.rewards_paymentFailed.tr(),
          ),
        );
      }
    }
  }

  Future<void> updatePoint({required int point}) async {
    await UserService().updatePoint(point: point);
  }
}
