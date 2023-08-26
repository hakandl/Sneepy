import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class RevenueCatService {
  static Future<List<Offering>> getOffers() async {
    try {
      final offerings = await Purchases.getOfferings();
      return offerings.all.values.toList();
    } on PlatformException {
      return [];
    }
  }
}
