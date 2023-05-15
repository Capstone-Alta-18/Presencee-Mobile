import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFE7968),
      body: Center(
        child: Image.asset(
          "lib/assets/images/logo_w.png",
          width: 200.0,
          height: 200.0,
        )
      ),
    );
  }
}