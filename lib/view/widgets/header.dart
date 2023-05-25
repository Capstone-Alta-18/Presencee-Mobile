import 'package:flutter/material.dart';
import 'package:presencee/theme/constant.dart';

class Header extends StatelessWidget {
  final String title, subtitle;
  const Header({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 237,
      width: double.maxFinite,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppTheme.gradient_1, AppTheme.gradient_2],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTextStyle.poppinsTextStyle(
                color: AppTheme.white,
                fontSize: 24,
                fontsWeight: FontWeight.w600
              )
            ),
            Text(
              subtitle,
              style: AppTextStyle.poppinsTextStyle(
                color: Colors.white,
                fontSize: 24,
                fontsWeight: FontWeight.w600
              )
            ),
          ],
        ),
      ),
    );
  }
}