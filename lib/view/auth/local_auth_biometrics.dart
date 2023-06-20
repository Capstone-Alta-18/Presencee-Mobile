import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:presencee/view/widgets/alerted_attendance.dart';

class AuthBiometrics {
  static final auth = LocalAuthentication();
  // List<BiometricType> availableBiometrics = [];

  static showFailedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Failed'),
        content: const Text('You are not authorized to access this app'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  static Future<void> checkAvailability() async {
    final isCheck = await auth.canCheckBiometrics;
    log(isCheck.toString(), name: "Can check biometrics?");
    final isDeviceSupport = await auth.isDeviceSupported();
    log(isDeviceSupport.toString(), name: "Device Support?");
    final isHasBio = await auth.getAvailableBiometrics();
    log(isHasBio.toString(), name: "Available Biometrics");
  }

  static Future<bool> hasBiometrics() async {
    try {
      return await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      log(e.toString(), name: "Can Check Biometrics?");
      return false;
    }
  }

  static Future<bool> authenticate() async {
    bool isAuthenticated = false;
    
    try {
      bool canCheckBiometrics = await hasBiometrics();
      
      if (canCheckBiometrics) {
        isAuthenticated = await auth.authenticate(
          localizedReason: 'Untuk Absen silahkan sidik jari kamu',
          options: const AuthenticationOptions(
            sensitiveTransaction: true,
            useErrorDialogs: true,
          ),
        );
      } else {
        debugPrint('Biometrics not available');
        // AllDialogsAttendance.failedDialog(context);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    if (isAuthenticated) {
      debugPrint('User is authenticated!');
    } else {
      debugPrint('User is not authenticated.');
    }
    return isAuthenticated;
  }

  
}