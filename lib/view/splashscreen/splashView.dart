import 'package:presencee/theme/constant.dart';
import 'package:flutter/material.dart';
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
      _showFirst = false;
    });
    await Future.delayed(Duration(milliseconds: 3200));
    Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => LoginPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: Duration(milliseconds: 1550),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 900),
      alignment: Alignment.center,
      crossFadeState: _showFirst ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      firstChild: const First(),
      secondChild: const Second(),
    );
  }
}

class First extends StatelessWidget {
  const First({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      color: AppTheme.primaryTheme,
      child: Center(
        child: Image.asset(
          "lib/assets/images/logo_w.png",
          width: 200.0,
          height: 200.0,
        ),
      )
    );
  }
}

class Second extends StatelessWidget {
  const Second({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
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