import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:presencee/theme/constant.dart';

class CardMatkul extends StatelessWidget {
  const CardMatkul({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
    width: 114,
    height: 128,
    child: Card(
      // shadowColor: Color.fromRGBO(29, 29, 29, 0.2),
      elevation: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularPercentIndicator(
            radius: 40.0,
            animation: true,
            animationDuration: 1200,
            lineWidth: 7.0,
            percent: 0.8,
            // startAngle: 0.5,
            center: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(225, 255, 230, 1),
                  shape: BoxShape.circle),
              child: const Center(
                child: Text(
                  "MU",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 22),
                ),
              ),
            ),
            backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
            progressColor: primaryTheme,
          ),
          const SizedBox(height: 10),
          const Text(
            'Bhs Indonesia',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          )
        ],
      ),
    ),
  );;
  }
}