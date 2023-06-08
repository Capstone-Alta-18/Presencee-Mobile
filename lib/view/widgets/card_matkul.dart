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
        ? SizedBox(
            height: 164,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 18),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: InkWell(
                      onTap: () {},
                      child: SizedBox(
                        width: 132,
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
                                    color: AppTheme.greenCard,
                                    shape: BoxShape.circle),
                                child: Center(
                                  child: Text(
                                    "MU",
                                    style: AppTextStyle.poppinsTextStyle(
                                        color: AppTheme.black,
                                        fontSize: 22,
                                        fontsWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              backgroundColor: AppTheme.gray,
                              progressColor: AppTheme.primaryTheme,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Bhs Indonesia',
                              style: AppTextStyle.poppinsTextStyle(
                                color: AppTheme.black,
                                fontSize: 12,
                                fontsWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
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
                      color: AppTheme.greenCard,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        "MU",
                        style: AppTextStyle.poppinsTextStyle(
                            color: AppTheme.black,
                            fontSize: 22,
                            fontsWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  backgroundColor: AppTheme.gray,
                  progressColor: AppTheme.primaryTheme,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bhs Indonesia',
                        style: AppTextStyle.poppinsTextStyle(
                          color: AppTheme.black,
                          fontSize: 16,
                          fontsWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Siswandi',
                        style: AppTextStyle.poppinsTextStyle(
                          color: AppTheme.black,
                          fontSize: 14,
                          fontsWeight: FontWeight.w400,
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
                icon: const Icon(
                  PhosphorIcons.caret_right,
                  color: AppTheme.black_3,
                ),
              ),
            ],
          );
  }
}
