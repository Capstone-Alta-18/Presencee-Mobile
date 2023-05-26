import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:presencee/theme/constant.dart';


class Header extends StatelessWidget {
  final String title, subtitle;
  final bool back;
  const Header(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.back});

  @override
  Widget build(BuildContext context) {
    return back == false
        ? Container(
            height: 237,
            width: double.maxFinite,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppTheme.gradient_1, AppTheme.gradient_3],
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
                      fontsWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: AppTextStyle.poppinsTextStyle(
                      color: AppTheme.white,
                      fontSize: 24,
                      fontsWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          )
        : Container(
            height: 306,
            width: double.maxFinite,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppTheme.gradient_1, AppTheme.gradient_3],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 24, top: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      PhosphorIcons.arrow_left,
                      color: AppTheme.white,
                      size: 28,
                    ),
                    padding: EdgeInsets.zero,
                    alignment: Alignment.centerLeft,
                  ),
                  const SizedBox(height: 70),
                  Text(
                    title,
                    style: AppTextStyle.poppinsTextStyle(
                      color: AppTheme.white,
                      fontSize: 24,
                      fontsWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: AppTextStyle.poppinsTextStyle(
                      color: AppTheme.white,
                      fontSize: 24,
                      fontsWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
