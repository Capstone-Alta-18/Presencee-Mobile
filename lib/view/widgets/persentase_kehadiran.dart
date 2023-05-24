import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:presencee/theme/constant.dart';

class PersentaseKehadiran extends StatelessWidget {
  const PersentaseKehadiran({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 75, left: 95, right: 95),
      child: Transform(
        transform: Matrix4.rotationZ(0.0),
        alignment: FractionalOffset.center,
        child: CircularPercentIndicator(
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
                  color: Colors.black,
                  fontSize: 28,
                  fontsWeight: FontWeight.w600
                )
              ),
              const SizedBox(height: 10),
              Container(
                width: 120,
                height: 28,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: AppTheme.primaryTheme_3,
                  borderRadius: BorderRadius.circular(24)
                ),
                child: Text(
                  "Minggu ke-10",
                  style: AppTextStyle.poppinsTextStyle(
                    color: AppTheme.white,
                    fontSize: 12,
                    fontsWeight: FontWeight.w600
                  ),
                ),
              )
            ],
          ),
          backgroundColor: AppTheme.gray,
          progressColor: AppTheme.primaryTheme,
        ),
      ));
  }
}