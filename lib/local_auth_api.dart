import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';


class LocalAuthApi {
  static final auth = LocalAuthentication();

  static Future<bool> isDeviceSupported() async {
    try {
      return await auth.isDeviceSupported();
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  static Future<bool> canCheckBiometrics() async {
    try {
      return await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<List<BiometricType>> getBiometrics() async {
    try {
      return await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      return <BiometricType>[];
    }
  }

  static Future<bool> authenticate() async {
    final isAvailable = await isDeviceSupported() && await canCheckBiometrics();
    if (!isAvailable) return false;
    try {
      return await auth.authenticate(
        localizedReason: 'Scan fingerprint to authenticate',
        authMessages: const [
          AndroidAuthMessages(
              signInTitle: 'Scan fingerprint to authenticate',
              cancelButton: 'No thanks',
              biometricSuccess: 'Success'),
          IOSAuthMessages(
            localizedFallbackTitle: 'Scan fingerprint to authenticate',
            cancelButton: 'No thanks',
          ),
        ],
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
          biometricOnly: false,
          sensitiveTransaction: true,
        ),
      );
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}