import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: LottieBuilder.asset(
                    "lib/assets/animation/under-maintenance.json")),
            const SizedBox(height: 44),
            Text(
              "Maaf atas ketidaknyamanan, Halaman ini dalam perbaikan",
              textAlign: TextAlign.center,
              style: AppTextStyle.poppinsTextStyle(
                fontSize: 20,
                fontsWeight: FontWeight.w500,
                color: AppTheme.primaryTheme,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
