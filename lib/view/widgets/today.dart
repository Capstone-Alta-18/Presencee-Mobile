import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:intl/intl.dart';
import 'package:presencee/theme/constant.dart';

class TodayWidgets extends StatelessWidget {
  final bool presensi;
  final bool back;
  final DateTime currentTime;
  const TodayWidgets(
      {super.key,
      required this.presensi,
      required this.back,
      required this.currentTime});

  @override
  Widget build(BuildContext context) {
    return presensi == false && back == false
        ? Container(
            height: 237,
            width: double.maxFinite,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppTheme.gray_2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  // DateFormat('EEEE, d MMMM yyyy', 'id').format(DateTime.now()),
                  DateFormat('EEEE, d MMMM yyyy', 'id').format(currentTime),
                  style: AppTextStyle.poppinsTextStyle(
                      color: AppTheme.white,
                      fontSize: 14,
                      fontsWeight: FontWeight.w400),
                ),
                Text(
                  // DateFormat('HH.mm').format(DateTime.now()),
                  DateFormat('HH.mm').format(currentTime),
                  style: AppTextStyle.poppinsTextStyle(
                    color: AppTheme.white,
                    fontSize: 45,
                    fontsWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          )
        : presensi == true && back == false
            ? Container(
                height: MediaQuery.of(context).size.height,
                width: double.maxFinite,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.gray_2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
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
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            PhosphorIcons.arrow_left,
                            color: AppTheme.white,
                            size: 28,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 27),
                    Text(
                      DateFormat('EEEE, d MMMM yyyy', 'id')
                          .format(DateTime.now()),
                      style: AppTextStyle.poppinsTextStyle(
                          color: AppTheme.white,
                          fontSize: 14,
                          fontsWeight: FontWeight.w400),
                    ),
                    Text(
                      DateFormat('HH.mm').format(DateTime.now()),
                      style: AppTextStyle.poppinsTextStyle(
                        color: AppTheme.white,
                        fontSize: 45,
                        fontsWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                height: MediaQuery.of(context).size.height,
                width: double.maxFinite,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.gray_2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
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
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            PhosphorIcons.x,
                            color: AppTheme.white,
                            size: 28,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 27),
                    Text(
                      DateFormat('EEEE, d MMMM yyyy', 'id')
                          .format(DateTime.now()),
                      style: AppTextStyle.poppinsTextStyle(
                          color: AppTheme.white,
                          fontSize: 14,
                          fontsWeight: FontWeight.w400),
                    ),
                    Text(
                      DateFormat('HH.mm').format(DateTime.now()),
                      style: AppTextStyle.poppinsTextStyle(
                        color: AppTheme.white,
                        fontSize: 45,
                        fontsWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              );
  }
}
