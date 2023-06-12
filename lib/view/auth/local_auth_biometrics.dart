import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class AuthBiometrics {
  static final auth = LocalAuthentication();
  List<BiometricType> availableBiometrics = [];

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

  static Future<bool> hasBiometrics() async {
    try {
      return await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      return false;
    }
  }

  static Future<bool> authenticate() async {
    bool isAuthenticated = false;
    
    try {
      bool canCheckBiometrics = await hasBiometrics();
      
      if (canCheckBiometrics) {
        isAuthenticated = await auth.authenticate(
          localizedReason: 'Authenticate to proceed',
          options: const AuthenticationOptions(
            sensitiveTransaction: true,
          ),
          /* authMessages: const <AuthMessages>[
            AndroidAuthMessages(),
            IOSAuthMessages(),
            WindowsAuthMessages(),
          ] */
        );
      } else {
        debugPrint('Biometrics not available');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    if (isAuthenticated) {
      debugPrint('User is authenticated!');
    } else {
      debugPrint('User is not authenticated.');
      // return showFailedDialog(context);
    }
    return isAuthenticated;
  }

  
}