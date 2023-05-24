import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:presencee/view/widgets/legend_widget.dart';

class BarChartWidget extends StatelessWidget {
  BarChartWidget({super.key});

  final List<double> data = [10, 5, 8, 3, 6];
  final hadirColor = const Color.fromRGBO(254, 175, 164, 1);
  final absenColor = const Color.fromRGBO(174, 56, 56, 1);
  final terlambatColor = const Color.fromRGBO(255, 155, 4, 1);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 344,
      height: 304,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
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
              IconButton(
                onPressed: () {},
                icon: Image.asset("lib/assets/icons/arrow_left.png"),
              ),
              Column(
                children: [
                  Container(
                    height: 27,
                    width: 130,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(254, 148, 134, 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text(
                        'Minggu ke-8',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Color.fromRGBO(36, 36, 36, 1)),
                      ),
                    ),
                  ),
                  const Text(
                    '10-14 April 2022',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                        color: Color.fromRGBO(36, 36, 36, 1)),
                  )
                ],
              ),
              IconButton(
                onPressed: () {},
                icon: Image.asset("lib/assets/icons/arrow_right.png"),
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
                      getTextStyles: (value) => const TextStyle(
                        color: Color.fromRGBO(36, 36, 36, 1),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
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
                                  const Color.fromRGBO(254, 175, 164, 1)
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
