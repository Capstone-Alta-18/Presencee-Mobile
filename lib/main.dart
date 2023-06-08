import 'package:presencee/provider/kehadiran_viewModel.dart';
import 'package:presencee/view/pages/customers_view.dart';
import 'package:presencee/view/pages/mahasiswa_Viewmodel.dart';
import 'package:presencee/view/pages/fingerprint_view.dart';
import 'package:presencee/view/pages/presence_view.dart';
import 'package:presencee/view/pages/semester_attendance_history_view.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:presencee/view/splashscreen/splashView.dart';
import 'package:presencee/view/auth/login_view.dart';
import 'package:presencee/view/home/homePage.dart';
import 'package:presencee/theme/constant.dart';
import 'package:presencee/view_model/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MahasiswaViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => KehadiranViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserViewModel(),
        ),
      ],
      child: MaterialApp(
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
        initialRoute: '/',
        routes: {
          '/': (context) => const IntroductionScreen(),
          '/login': (context) => const LoginPage(),
          '/home': (context) => HomePage(),
          '/semester_history': (context) => const SemesterHistory(),
          // '/course_history' : (context) => CourseHistory(selectedIndex: 0, manager: KehadiranViewModel(),),
          '/presence': (context) => const PresenceView(),
          '/fingerprint': (context) => const FingerprintView(),
          '/help_center': (context) => const CustomerService(),
        },
      ),
    );
  }
}
