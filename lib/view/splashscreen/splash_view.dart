import 'package:flutter/material.dart';
import 'package:presencee/model/API/privates.dart';
import 'package:presencee/theme/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  bool _showFirst = true;
  late SharedPreferences login;
  late bool newUser;

  @override
  void initState() {
    super.initState();
    _changeView();
  }

  void _changeView() async {
    await Future.delayed(const Duration(milliseconds: 800));
    setState(() {
      _showFirst = false;
    });
    await Future.delayed(const Duration(milliseconds: 3200));
    checkLogin();
  }

  void checkLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString('token');
    final id = sharedPreferences.getInt('id_mahasiswa');
    if (token == null || id == null) {
      if (mounted) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('//login', (route) => false);
      }
    } else {
      apiToken = token;
      if (mounted) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('//home', (route) => false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 900),
      alignment: Alignment.center,
      crossFadeState:
          _showFirst ? CrossFadeState.showFirst : CrossFadeState.showSecond,
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
