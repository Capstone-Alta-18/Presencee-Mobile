import 'package:flutter/material.dart';
import 'package:presencee/view/widgets/bottomsheet_fingerprint.dart';
import 'package:presencee/view/widgets/today.dart';

class FingerprintView extends StatefulWidget {
  const FingerprintView({super.key});

  @override
  State<FingerprintView> createState() => _FingerprintViewState();
}

class _FingerprintViewState extends State<FingerprintView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          // alignment: Alignment.center,
          children: [
            TodayWidgets(presensi: true,back: true),
            FingerprintBottomsheet(),
          ],
        ),
      ),
    );
  }
}