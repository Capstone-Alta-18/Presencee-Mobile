import 'package:flutter/material.dart';
import 'package:presencee/view/widgets/bottomsheet_fingerprint.dart';
import 'package:presencee/view/widgets/today.dart';

class FingerprintView extends StatelessWidget {
  const FingerprintView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            TodayWidgets(presensi: true,back: true),
            FingerprintBottomsheet(),
          ],
        ),
      ),
    );
  }
}