import 'package:flutter/material.dart';
import 'package:presencee/theme/contant.dart';
import '../auth/login_view.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  bool _showFirst = true;

  @override
  void initState() {
    super.initState();
    _changeView();
  }

  void _changeView() async {
    await Future.delayed(Duration(milliseconds: 800));
    setState(() {
      _showFirst = false;     // duration 300ms
    });
    await Future.delayed(Duration(milliseconds: 1400));
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, _) => const LoginPage(),
        transitionDuration: const Duration(milliseconds: 800),
        transitionsBuilder: (context, animation, _, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 500),
      crossFadeState: _showFirst ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      sizeCurve: Curves.easeIn,
      firstChild: First(),
      secondChild: Second(),
    );
  }
}

class First extends StatelessWidget {
  const First({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: primaryTheme,
      child: Center(
        child: Image.asset(
          "lib/assets/images/logo_w.png",
          width: 200.0,
          height: 200.0,
        ),
      ),
    );
  }
}

class Second extends StatelessWidget {
  const Second({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Center(
        child: Image.asset(
          "lib/assets/images/logo_color.png",
          width: 200.0,
          height: 200.0,
        ),
      ),
    );
  }
}