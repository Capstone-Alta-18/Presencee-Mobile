import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:presencee/theme/constant.dart';

class PersentaseKehadiran extends StatelessWidget {
  final bool diagram;
  const PersentaseKehadiran({super.key, required this.diagram});

  @override
  Widget build(BuildContext context) {
    return diagram == false
    ? CircularPercentIndicator(
        radius: 105.0,
        animation: true,
        animationDuration: 1200,
        lineWidth: 15.0,
        percent: 0.8,
        center: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "62,5%",
              style: AppTextStyle.poppinsTextStyle(
                color: AppTheme.black,
                fontSize: 28,
                fontsWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: 127,
              height: 27,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: AppTheme.primaryTheme,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Text(
                "Minggu ke-10",
                style: AppTextStyle.poppinsTextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontsWeight: FontWeight.w600,
                ),
              ),
            )
          ],
        ),
        backgroundColor: AppTheme.gray,
        progressColor: AppTheme.primaryTheme,
      )
    : CircularPercentIndicator(
        radius: 120.0,
        animation: true,
        animationDuration: 1200,
        lineWidth: 30.0,
        percent: 0.8,
        center: Text(
          "63,5%",
          style: AppTextStyle.poppinsTextStyle(
            color: AppTheme.black,
            fontSize: 40,
            fontsWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: AppTheme.gray,
        progressColor: AppTheme.primaryTheme,
      );
  }
}
