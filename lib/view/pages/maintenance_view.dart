import 'package:flutter/material.dart';
import 'package:presencee/theme/constant.dart';

class MaintenancePage extends StatelessWidget {
  const MaintenancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("lib/assets/images/maintenance.png"),
            Padding(padding: EdgeInsets.only(bottom: 44)),
            Text("Halaman ini dalam \nperbaikan",
              textAlign: TextAlign.center,
              style: AppTextStyle.poppinsTextStyle(
                fontSize: 24,
                fontsWeight: FontWeight.w500,
                color: AppTheme.black
              ),
            ),
          ],
        ),
      ),
    );
  }
}