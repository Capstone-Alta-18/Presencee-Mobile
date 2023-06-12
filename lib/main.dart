import 'package:presencee/view/pages/helps/help_center_view.dart';
import 'package:presencee/view/pages/semester_attendance_history_view.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:presencee/view/splashscreen/splash_view.dart';
import 'package:presencee/view/widgets/kehadiran_semester.dart';
import 'package:presencee/view/pages/helps/customer_view.dart';
import 'package:presencee/view/pages/fingerprint_view.dart';
import 'package:presencee/view/pages/presence_view.dart';
import 'package:presencee/view/pages/schedule_view.dart';
import 'package:presencee/view/pages/history_view.dart';
import 'package:presencee/view/pages/profile_view.dart';
import 'package:presencee/view/auth/login_view.dart';
import 'package:presencee/view/home/homePage.dart';
import 'package:presencee/theme/constant.dart';
import 'view_model/kehadiran_view_model.dart';
import 'view_model/mahasiswa_view_model.dart';
import 'view_model/user_view_model.dart';
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
        ChangeNotifierProvider(create: (context) => MahasiswaViewModel()),
        ChangeNotifierProvider(create: (context) => KehadiranViewModel()),
        ChangeNotifierProvider(create: (context) => UserViewModel()),
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
          '/': (_) => const IntroductionScreen(),
          '/login': (_) => const LoginPage(),
          '/home': (_) => const HomePage(),
          '/schedule': (_) => const SchedulePage(),
          '/history': (_) => const HistoryPage(),
          '/profiles': (_) => const ProfilePage(),
          '/semester_present': (_) => const KehadiranSemester(),
          // '/course_history' : (_) => CourseHistory(selectedIndex: 0, manager: KehadiranViewModel(),),
          '/presence': (_) => const PresenceView(),
          '/fingerprint': (_) => const FingerprintView(),
          '/help': (_) => const CustomerService(),
          '/underMaintenance': (_) => const PusatBantuanPage(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '//home') {
            return PageRouteBuilder(
              transitionsBuilder: (_, __, ___, c) {
                return FadeTransition(
                  opacity: __,
                  child: c,
                );
              },
              transitionDuration: const Duration(milliseconds: 1330),
              pageBuilder: (_, __, ___) => const HomePage(),
            );
          } else if (settings.name == '//login') {
            return PageRouteBuilder(
              pageBuilder: (_, __, ___) => const LoginPage(),
              transitionsBuilder: (_, __, ___, c) {
                return FadeTransition(
                  opacity: __,
                  child: c,
                );
              },
              transitionDuration: const Duration(milliseconds: 1330),
            );
          } else if (settings.name == '//help') {
            return PageRouteBuilder(
              pageBuilder: (_, __, ___) => const CustomerService(),
              transitionsBuilder: (_, __, ___, c) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: Offset.zero,
                  ).animate(__),
                  child: c,
                );
              },
              transitionDuration: const Duration(milliseconds: 450),
            );
          } else if (settings.name == '/history/semester_history') {
            return PageRouteBuilder(
              pageBuilder: (_, __, ___) => const SemesterHistory(),
              transitionsBuilder: (_, a, sA, c) {
                var begin = const Offset(1.0, 0.0);
                var end = Offset.zero;
                var curve = Curves.ease;
                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                return SlideTransition(
                  position: a.drive(tween),
                  child: c,
                );
              },
              transitionDuration: const Duration(milliseconds: 500),
            );
          } else if (settings.name == '/schedule/presence') {
            return PageRouteBuilder(
              transitionsBuilder: (_, a, sA, c) {
                var tween = Tween<double>(begin: 0.0, end: 1.0);
                var curvedAnimation = CurvedAnimation(
                  parent: a,
                  curve: Curves.ease,
                );
                return FadeTransition(
                  opacity: tween.animate(curvedAnimation),
                  child: c,
                );
              },
              pageBuilder: (_, __, ___) => const PresenceView(),
            );
          } else if (settings.name == '/schedule/presence/fingerprint') {
            return PageRouteBuilder(
              transitionsBuilder: (_, a, sA, c) {
                var tween = Tween<double>(begin: 0.0, end: 1.0);
                var curvedAnimation = CurvedAnimation(
                  parent: a,
                  curve: Curves.ease,
                );
                return FadeTransition(
                  opacity: tween.animate(curvedAnimation),
                  child: c,
                );
              },
              pageBuilder: (_, __, ___) => const FingerprintView(),
            );
          } else if (settings.name == '/profiles/underMaintenance') {
            return PageRouteBuilder(
              pageBuilder: (_, __, ___) => const PusatBantuanPage(),
              transitionsBuilder: (_, __, ___, c) => FadeTransition(opacity: __, child: c),
              transitionDuration: const Duration(milliseconds: 300),
            );
          }
          return null;
        },
      ),
    );
  }
}
