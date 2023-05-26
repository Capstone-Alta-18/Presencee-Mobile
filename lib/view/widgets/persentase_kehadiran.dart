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
                const Text(
                  "62,5%",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 28),
                ),
                const SizedBox(height: 10),
                Container(
                  width: 127,
                  height: 27,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: primaryTheme,
                      borderRadius: BorderRadius.circular(24)),
                  child: const Text(
                    "Minggu ke-10",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
            backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
            progressColor: primaryTheme,
          )
        : CircularPercentIndicator(
            radius: 105.0,
            animation: true,
            animationDuration: 1200,
            lineWidth: 24.0,
            percent: 0.8,
            center: const Text(
              "62,5%",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 28),
            ),
            backgroundColor: const Color.fromRGBO(209, 209, 209, 1),
            progressColor: primaryTheme,
          );


  }
}
