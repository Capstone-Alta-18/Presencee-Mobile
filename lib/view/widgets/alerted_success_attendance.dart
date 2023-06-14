import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:presencee/theme/constant.dart';

class AllDialogsAttendance {

  void successDialog(BuildContext context) {
    // snack bar dialog
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              color: AppTheme.success,
            ),
            SizedBox(width: 5),
            Text(
              'Presensi Berhasil',
              style: TextStyle(
                color: AppTheme.black,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ],
        ),
        duration: const Duration(milliseconds: 900),
        dismissDirection: DismissDirection.up,
        margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 1.2, left: 20, right: 20),
        backgroundColor: AppTheme.white,
        behavior: SnackBarBehavior.floating,
        /* shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ), */
      ),
    );
  }

  void failedDialog(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              PhosphorIcons.x_circle_fill,
              color: AppTheme.error,
            ),
            SizedBox(width: 5),
            Text(
              'Presensi Gagal, kelas telah selesai...',
              style: TextStyle(
                color: AppTheme.black,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ],
        ),
        duration: const Duration(milliseconds: 1200),
        dismissDirection: DismissDirection.up,
        margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 1.2, left: 20, right: 20),
        backgroundColor: AppTheme.white,
        behavior: SnackBarBehavior.floating,
        /* shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ), */
      ),
    );
  }

  void warningDialog(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error,
              color: AppTheme.warningOrange,
            ),
            SizedBox(width: 5),
            Text(
              'Presensi Gagal, kelas telah selesai...',
              style: TextStyle(
                color: AppTheme.black,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ],
        ),
        duration: const Duration(milliseconds: 1200),
        dismissDirection: DismissDirection.up,
        margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 1.2, left: 20, right: 20),
        backgroundColor: AppTheme.white,
        behavior: SnackBarBehavior.floating,
        /* shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ), */
      ),
    );
  }
}