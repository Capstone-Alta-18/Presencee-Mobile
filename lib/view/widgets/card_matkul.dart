import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:presencee/theme/constant.dart';

class CardMatkul extends StatelessWidget {
  final bool semester;
  const CardMatkul({
    super.key,
    required this.semester,
  });

  @override
  Widget build(BuildContext context) {
    return semester == false
        ? Column(
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
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: CircularPercentIndicator(
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
              ),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bhs Indonesia',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Siswandi',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/course_history');
                },
                // icon: Image.asset('lib/assets/icons/caret_right.png'),
                icon: const Icon(PhosphorIcons.caret_right,color: Color.fromRGBO(97, 97, 97, 1)),
              ),
            ],
          );
  }
}
