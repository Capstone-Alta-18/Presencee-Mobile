import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:presencee/theme/constant.dart';
import 'package:presencee/view/widgets/legend_widget.dart';

class BarChartWidget extends StatelessWidget {
  BarChartWidget({super.key});

  final List<double> data = [10, 5, 8, 3, 6];
  final hadirColor = AppTheme.primaryTheme_3;
  final absenColor = AppTheme.error;
  final terlambatColor = const Color.fromRGBO(255, 155, 4, 1);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      width: double.infinity,
      height: 316,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(26, 0, 0, 0).withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Material(
                child: IconButton(
                  onPressed: () {},
                  icon: Image.asset("lib/assets/icons/arrow_left.png"),
                ),
              ),
              Column(
                children: [
                  const SizedBox(height: 18),
                  Container(
                    height: 27,
                    width: 130,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryTheme_2,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        'Minggu ke-8',
                        style: AppTextStyle.poppinsTextStyle(
                          color: AppTheme.white,
                          fontSize: 14,
                          fontsWeight: FontWeight.w500
                        ),
                      ),
                    ),
                  ),
                  Text(
                    '10-14 April 2022',
                    style: AppTextStyle.poppinsTextStyle(
                      color: AppTheme.black,
                      fontSize: 12,
                      fontsWeight: FontWeight.w400
                    ),
                  )
                ],
              ),
              Material(
                child: IconButton(
                  onPressed: () {},
                  icon: Image.asset("lib/assets/icons/arrow_right.png"),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 50, right: 50, top: 10, bottom: 10),
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 10,
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: SideTitles(
                      showTitles: true,
                      getTextStyles: (value) => AppTextStyle.poppinsTextStyle(
                        color: AppTheme.black_2,
                        fontSize: 12,
                        fontsWeight: FontWeight.w400
                      ),
                      margin: 16,
                      getTitles: (double value) {
                        switch (value.toInt()) {
                          case 0:
                            return 'Mon';
                          case 1:
                            return 'Tue';
                          case 2:
                            return 'Wed';
                          case 3:
                            return 'Thu';
                          case 4:
                            return 'Fri';
                          default:
                            return '';
                        }
                      },
                    ),
                    leftTitles: SideTitles(showTitles: false),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: data
                      .asMap()
                      .map(
                        (index, value) => MapEntry(
                          index,
                          BarChartGroupData(
                            x: index,
                            barRods: [
                              BarChartRodData(
                                y: value,
                                colors: [
                                  AppTheme.primaryTheme_3
                                ],
                                width: 8,
                              ),
                            ],
                          ),
                        ),
                      )
                      .values
                      .toList(),
                ),
              ),
            ),
          ),
          const SizedBox(height: 11),
          LegendsListWidget(
            legends: [
              Legend('Hadir', hadirColor),
              Legend('Absen', absenColor),
              Legend('Terlambat', terlambatColor),
            ],
          ),
          const SizedBox(height: 17),
        ],
      ),
    );
  }
}
