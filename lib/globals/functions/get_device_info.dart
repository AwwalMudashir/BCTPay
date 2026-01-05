import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfo {
  static DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  static AndroidDeviceInfo? androidInfo;
  static IosDeviceInfo? iosInfo;

  static Future<void> init() async {
    if (Platform.isAndroid) {
      androidInfo = await deviceInfo.androidInfo;
    } else if (Platform.isIOS) {
      iosInfo = await deviceInfo.iosInfo;
    } else {
      throw Exception('Unsupported platform');
    }
  }

  static Future<String> getDeviceName() async {
    if (Platform.isAndroid) {
      // final androidInfo = await deviceInfo.androidInfo;
      return androidInfo!.brand;
    } else if (Platform.isIOS) {
      // final iosInfo = await deviceInfo.iosInfo;
      return iosInfo!.name;
    } else {
      throw Exception('Unsupported platform');
    }
  }

  static Future<String> getDeviceId() async {
    if (Platform.isAndroid) {
      // final androidInfo = await deviceInfo.androidInfo;
      return androidInfo!.id;
    } else if (Platform.isIOS) {
      // final iosInfo = await deviceInfo.iosInfo;
      return iosInfo!.identifierForVendor ?? "";
    } else {
      throw Exception('Unsupported platform');
    }
  }

  static Future<String> getDeviceOSVersion() async {
    if (Platform.isAndroid) {
      return androidInfo!.version.release;
    } else if (Platform.isIOS) {
      return iosInfo!.systemVersion;
    } else {
      throw Exception('Unsupported platform');
    }
  }

  static Future<String> getDeviceModel() async {
    if (Platform.isAndroid) {
      return androidInfo!.model;
    } else if (Platform.isIOS) {
      return iosInfo!.model;
    } else {
      throw Exception('Unsupported platform');
    }
  }
}
