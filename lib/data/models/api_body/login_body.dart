import 'dart:io';

import 'package:bctpay/data/firebase/firebase_messaging.dart';
import 'package:bctpay/globals/functions/get_device_info.dart';
import 'package:flutter/foundation.dart';

class LoginBody {
  final String loginType;
  final String? phoneCode;
  final String? email;
  final String password;
  final String deviceName;
  final String deviceId;
  final String deviceToken;
  final String lastLoginIp;
  final String model;
  final String os;
  final String osVersion;
  final String? otp;

  LoginBody({
    required this.loginType,
    this.phoneCode,
    this.email,
    required this.password,
    required this.deviceName,
    required this.deviceId,
    required this.deviceToken,
    required this.lastLoginIp,
    required this.model,
    required this.os,
    required this.osVersion,
    required this.otp,
  });

  /// Converts instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'login_type': loginType,
      'phone_code': phoneCode,
      'email': email,
      'password': password,
      'device_name': deviceName,
      'device_id': deviceId,
      'device_token': deviceToken,
      'last_login_ip': lastLoginIp,
      'model': model,
      'os': os,
      'os_version': osVersion,
      'otp': otp,
    };
  }

  /// Factory method to create instance from current device info
  static Future<LoginBody> from({
    required String password,
    String? email,
    String? phoneCode,
    String? otp,
  }) async {
    final deviceName = await DeviceInfo.getDeviceName();
    final deviceId = await DeviceInfo.getDeviceId();
    final model = await DeviceInfo.getDeviceModel();
    final osVersion = await DeviceInfo.getDeviceOSVersion();
    final deviceToken = Platform.isIOS
        ? (kReleaseMode ? await getFcmToken() : "12345")
        : await getFcmToken();

    return LoginBody(
      loginType: 'PHONE',
      phoneCode: phoneCode,
      email: email,
      password: password,
      deviceName: deviceName,
      deviceId: deviceId,
      deviceToken: deviceToken ?? "",
      lastLoginIp: '106.76.92.240',
      model: model,
      os: Platform.operatingSystem,
      osVersion: osVersion,
      otp: otp,
    );
  }

  LoginBody copyWith({
    String? loginType,
    String? phoneCode,
    String? email,
    String? password,
    String? deviceName,
    String? deviceId,
    String? deviceToken,
    String? lastLoginIp,
    String? model,
    String? os,
    String? osVersion,
    String? otp,
  }) {
    return LoginBody(
      loginType: loginType ?? this.loginType,
      phoneCode: phoneCode ?? this.phoneCode,
      email: email ?? this.email,
      password: password ?? this.password,
      deviceName: deviceName ?? this.deviceName,
      deviceId: deviceId ?? this.deviceId,
      deviceToken: deviceToken ?? this.deviceToken,
      lastLoginIp: lastLoginIp ?? this.lastLoginIp,
      model: model ?? this.model,
      os: os ?? this.os,
      osVersion: osVersion ?? this.osVersion,
      otp: otp ?? this.otp,
    );
  }
}
