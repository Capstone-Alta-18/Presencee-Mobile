import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:presencee/view/auth/login_view.dart';
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
// <<<<<<< HEAD
//         debugShowCheckedModeBanner: false,
//         theme: Theme.of(context).copyWith(
//           colorScheme: const ColorScheme.light(
//             primary: primaryTheme
//           ),
//         ),
//         routes: {
//           '/': (context) => const IntroductionScreen(),
//           '/home': (context) => HomePage(),
//         });
// =======
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('id', 'ID'),
        ],
        debugShowCheckedModeBanner: false,
        theme: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: AppTheme.primaryTheme,
            secondary: AppTheme.primaryTheme,
            // tertiary: primaryTheme,
          ),
        ),
        routes: {
          '/': (context) => const IntroductionScreen(),
          '/login': (context) => const LoginPage(),
          '/home': (context) => HomePage(),
        });
  }
}
