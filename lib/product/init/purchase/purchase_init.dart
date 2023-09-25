import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:sneepy/product/constants/service.dart';

class PurchaseInit {
  static const apiKey = ServiceConstants.revenueCatApiKey;

  Future<void> init() async {
    await Purchases.setLogLevel(LogLevel.info);

    PurchasesConfiguration configuration;
    configuration = PurchasesConfiguration(apiKey);

    await Purchases.configure(configuration);
  }
}
