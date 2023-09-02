import 'package:device_info_plus/device_info_plus.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:sneepy/product/cache/hive_manager.dart';
import 'package:sneepy/product/constants/service.dart';
import 'package:sneepy/product/constants/strings.dart';

class NotificationInit {
  OneSignal oneSignal = OneSignal.shared;
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  String deviceId = AppStrings.empty;

  Future<void> getDeviceId() async {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    deviceId = androidInfo.id;
  }

  Future<void> init() async {
    await getDeviceId();
    oneSignal.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    oneSignal.promptUserForPushNotificationPermission();
    oneSignal.setAppId(ServiceConstants.oneSignalAppId);
    oneSignal.setExternalUserId(deviceId);
    await saveDeviceToken();
  }

  Future<void> saveDeviceToken() async {
    await HiveManager.save(key: BoxKeyNames.deviceToken.name, value: deviceId);
  }
}
