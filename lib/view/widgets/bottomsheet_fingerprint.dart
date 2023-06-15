import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:presencee/view/widgets/alerted_success_attendance.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
// import 'package:presencee/view/auth/local_auth_biometrics.dart';
import 'package:presencee/theme/constant.dart';
import 'package:flutter/material.dart';

class FingerprintBottomsheet extends StatefulWidget {
  const FingerprintBottomsheet({super.key});

  @override
  State<FingerprintBottomsheet> createState() => _FingerprintBottomsheetState();
}

class _FingerprintBottomsheetState extends State<FingerprintBottomsheet> {
  static final auth = LocalAuthentication();
  

  /* @override
  void initState() {
    AuthBiometrics.authenticate();
    super.initState();
  } */

  static Future<bool> hasBiometrics(BuildContext context) async {
    final isDeviceSupport = await auth.isDeviceSupported();
    try {
      bool canCheckBiometrics = await auth.canCheckBiometrics;
      if (!canCheckBiometrics) {
        SnackbarAlertDialog().customDialogs(
          context, 
          message: "Presensi Gagal",
          icons: PhosphorIcons.x_circle_fill,
          iconColor: AppTheme.error,
          backgroundsColor: AppTheme.white,
          durations: 1200
        );
      }
      return canCheckBiometrics;
    } on PlatformException catch (e) {
      SnackbarAlertDialog().customDialogs(
        context,
        message: "Presensi Gagal, tidak ada sidik jari",
        icons: PhosphorIcons.x_circle_fill,
        iconColor: AppTheme.error,
        backgroundsColor: AppTheme.white,
        durations: 1200
      );
      return false;
    }
  }

  Future<void> authenticate() async {
    bool isAuthenticated = false;
    bool canCheckBiometrics = await hasBiometrics(context);

    if (canCheckBiometrics) {
      isAuthenticated = await auth.authenticate(
        localizedReason: 'Untuk absen silahkan masukan sidik jari anda',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );

      if (isAuthenticated) {
        SnackbarAlertDialog().customDialogs(
          context, message: "Presensi Berhasil", 
          icons: PhosphorIcons.check_circle, 
          iconColor: AppTheme.success,
          backgroundsColor: AppTheme.white,
          durations: 900
        );
        await Future.delayed(const Duration(milliseconds: 350));
        Navigator.pop(context);
        Navigator.pop(context);
      } else {
        SnackbarAlertDialog().customDialogs(
          context, 
          message: "Presensi Gagal, tidak ada sidik jari", 
          icons: PhosphorIcons.x_circle_fill, 
          iconColor: AppTheme.error,
          backgroundsColor: AppTheme.white,
          durations: 1200
        );
      }
    } else {
      SnackbarAlertDialog().customDialogs(
        context, 
        message: "Presensi Gagal, kelas telah selesai",
        icons: PhosphorIcons.x_circle_fill,
        iconColor: AppTheme.error,
        backgroundsColor: AppTheme.white,
        durations: 1200);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 1.5,
        decoration: const BoxDecoration(
          color: AppTheme.gray,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 24),
            Text(
              'Bahasa Indonesia',
              style: AppTextStyle.poppinsTextStyle(
                color: AppTheme.black,
                fontsWeight: FontWeight.w600,
                fontSize: 24,
              ),
            ),
            Text(
              '(MU)',
              style: AppTextStyle.poppinsTextStyle(
                color: AppTheme.black,
                fontsWeight: FontWeight.w600,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Senin',
              style: AppTextStyle.poppinsTextStyle(
                color: AppTheme.black_2,
                fontsWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              '07.00 - 09.00',
              style: AppTextStyle.poppinsTextStyle(
                color: AppTheme.black_2,
                fontsWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Kristina Fabulous',
              style: AppTextStyle.poppinsTextStyle(
                color: AppTheme.black,
                fontsWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              '200280120739',
              style: AppTextStyle.poppinsTextStyle(
                color: AppTheme.black_3,
                fontsWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 6),
            Text(
              'Letakkan sidik jari',
              style: AppTextStyle.poppinsTextStyle(
                color: AppTheme.black_3,
                fontsWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: 70,
              height: 90,
              child: OutlinedButton(
                onLongPress: () => authenticate(),
                onPressed: () => authenticate(),
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(0)),
                  side: MaterialStateProperty.all<BorderSide>(const BorderSide(color: AppTheme.gray_2, width: 3)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                child: const Icon(
                  PhosphorIcons.fingerprint,
                  size: 60,
                  color: AppTheme.gray_2,
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
