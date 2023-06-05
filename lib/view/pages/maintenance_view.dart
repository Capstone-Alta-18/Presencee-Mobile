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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Image.asset("lib/assets/images/maintenance.png"),
            ),
            const SizedBox(height: 44),
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