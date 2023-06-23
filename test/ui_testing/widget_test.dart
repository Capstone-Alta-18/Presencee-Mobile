import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:presencee/theme/constant.dart';
import 'package:presencee/view/auth/login_view.dart';
import 'package:presencee/view/home/homePage.dart';
import 'package:presencee/view/pages/helps/customer_view.dart';
import 'package:presencee/view/splash_view.dart';
import 'package:presencee/view_model/absensi_view_model.dart';
import 'package:presencee/view_model/dosen_view_model.dart';
// import 'package:presencee/main.dart' as app;

void main() {

  testWidgets("Testing Login Page", (WidgetTester tester) async {

    await tester.pumpWidget(
      MaterialApp(
        initialRoute: '/login',
        routes: {
          '/login': (_) => const LoginPage(),
          '/home': (_) => const HomePage(),
          '/help': (_) => const CustomerService(),
        },
      ),
    );
    expect(find.byType(IntroductionScreen), findsNothing);
    expect(find.byType(LoginPage), findsOneWidget);
    await tester.pump(const Duration(seconds: 3));

    Finder emailField = find.byKey(const Key('email'));
    await tester.enterText(emailField, 'test@gmail.com');
    expect(find.text('test@gmail.com'), findsOneWidget);

    Finder passwordField = find.byKey(const Key('password'));
    await tester.enterText(passwordField, '123456');
    expect(find.text('123456'), findsOneWidget);

    Finder loginButton = find.byKey(const Key('login-button'));
    await tester.tap(loginButton, warnIfMissed: false);
    await tester.pump(const Duration(seconds: 3));
  });
}
