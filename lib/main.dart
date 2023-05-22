import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:presencee/theme/constant.dart';
import 'package:presencee/view/home/homePage.dart';
import 'package:presencee/view/splashscreen/splashView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context).copyWith(
        colorScheme: const ColorScheme.light(
          primary: primaryTheme,
        ),
      ),
      routes: {
        '/': (context) => const IntroductionScreen(),
        '/home': (context) => HomePage(),
      }
    );
  }
}
