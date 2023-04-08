import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthApi {
  static final auth = LocalAuthentication();

  static Future<bool> hasBiometrics() async {
    try {
      return await auth.isDeviceSupported();
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  static Future<bool> authenticate() async {
    final isAvailable = await hasBiometrics();
    if (!isAvailable) return false;
    try {
      return await auth.authenticate(
        localizedReason: 'Scan fingerprint to authenticate',
        options: const AuthenticationOptions(
            useErrorDialogs: true, stickyAuth: true),
      );
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
