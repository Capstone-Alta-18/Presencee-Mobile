import 'package:flutter/material.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:presencee/main.dart' as app;
import 'package:presencee/view/auth/login_view.dart';
import 'package:presencee/view/home/homePage.dart';
import 'package:presencee/view/pages/helps/customer_view.dart';
import 'package:presencee/view/splash_view.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Forgot password page', (WidgetTester tester) async {
    
    app.main();
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    expect(find.byType(IntroductionScreen), findsNothing);
    expect(find.byType(LoginPage), findsOneWidget);

    Finder emailField = find.byKey(const Key('email'));
    await tester.enterText(emailField, 'test@gmail.com');

    Finder passwordField = find.byKey(const Key('password'));
    await tester.enterText(passwordField, '123456');
    await tester.testTextInput.receiveAction(TextInputAction.next);

    expect(find.byType(TextButton), anything);
    await tester.tap(find.byType(TextButton));
    await tester.pump();

    await tester.pump(const Duration(milliseconds: 800));
    expect(find.byType(CustomerService), findsOneWidget);
    expect(find.byType(Icon), findsOneWidget);
    await tester.tap(find.byType(Icon), warnIfMissed: false);
    await tester.press(find.byType(Icon), warnIfMissed: false);
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 2));
  });

   testWidgets('Testing login application', (WidgetTester tester) async {
    
    app.main();
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    expect(find.byType(IntroductionScreen), findsNothing);
    expect(find.byType(LoginPage), findsOneWidget);

    Finder emailField = find.byKey(const Key('email'));
    await tester.enterText(emailField, 'test@gmail.com');       // jika email salah test akan gagal

    Finder passwordField = find.byKey(const Key('password'));
    await tester.enterText(passwordField, '123456');
    await tester.testTextInput.receiveAction(TextInputAction.next);

    await tester.pump(const Duration(seconds: 2));
    Finder loginButton = find.byKey(const Key('login-button'));
    await tester.tap(loginButton, warnIfMissed: false);
    await tester.press(loginButton, warnIfMissed: false);
    await tester.pumpAndSettle();
    expect(find.byType(LoginPage), findsNothing);
    expect(find.byType(HomePage), findsOneWidget);
    await tester.pump(const Duration(seconds: 2));

    // Logout test
    /* Finder profile = find.byKey(const Key('profile-button'));
    await tester.tap(profile, warnIfMissed: false);
    await tester.press(profile, warnIfMissed: false);
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 2)); */
  });
}