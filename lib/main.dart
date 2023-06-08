import 'package:presencee/provider/kehadiran_viewModel.dart';
import 'package:presencee/view/pages/helps/customer_view.dart';
import 'package:presencee/view/pages/history_view.dart';
import 'package:presencee/view/pages/mahasiswa_Viewmodel.dart';
import 'package:presencee/view/pages/fingerprint_view.dart';
import 'package:presencee/view/pages/presence_view.dart';
import 'package:presencee/view/pages/profile_view.dart';
import 'package:presencee/view/pages/schedule_view.dart';
import 'package:presencee/view/pages/semester_attendance_history_view.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:presencee/view/pages/course_history_view.dart';
import 'package:presencee/view/splashscreen/splashView.dart';
import 'package:presencee/view/auth/login_view.dart';
import 'package:presencee/view/home/homePage.dart';
import 'package:presencee/theme/constant.dart';
import 'package:presencee/view/widgets/kehadiran_semester.dart';
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
          '/home': (_) => HomePage(),
          '/schedule': (_) => const SchedulePage(),
          '/history': (_) => const HistoryPage(),
          '/profiles': (_) => const ProfilePage(),
          '/semester_present': (_) => const KehadiranSemester(),
          // '/course_history' : (_) => CourseHistory(selectedIndex: 0, manager: KehadiranViewModel(),),
          '/presence': (_) => const PresenceView(),
          '/fingerprint': (_) => const FingerprintView(),
          '/help': (_) => const CustomerService(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/home') {
            return PageRouteBuilder(
              pageBuilder: (_, __, ___) => const HomePage(),
              transitionsBuilder: (_, a, sA, c) => FadeTransition(opacity: a, child: c),
              transitionDuration: const Duration(milliseconds: 1200),
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
          } 
          return null;
        },
      ),
    );
  }
}
