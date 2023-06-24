import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:presencee/theme/constant.dart';
import 'package:presencee/view/pages/history_view.dart';
import 'package:presencee/view/widgets/State_Status_widget.dart';
import 'package:presencee/view_model/kehadiran_view_model.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PersentaseKehadiran extends StatefulWidget {
  final bool diagram;
  final int selectedIndex;
  const PersentaseKehadiran(
      {super.key, required this.diagram, required this.selectedIndex});

  @override
  State<PersentaseKehadiran> createState() => _PersentaseKehadiranState();
}

class _PersentaseKehadiranState extends State<PersentaseKehadiran> {
  var afterTime = DateTime.utc(2023,06,19);
  var beforeTime = DateTime.utc(2023,06,30);
  List<DateTime> getWeeksForRange(DateTime start, DateTime end) {
  var result = List<DateTime>.empty(growable: true);
  
  var date = start;
  
  while(date.difference(end).inDays < 0) {   
    // start new week on Monday
    // if (date.weekday == 1) {
    //   result.add(date);
    // } 
    
    result.add(date);
    
    date = date.add(const Duration(days: 1));
  }
  
  // result.add(date);
  
  return result;
}

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    final manager = Provider.of<KehadiranViewModel>(context);
    final hadir = manager.kehadiranNew.meta!
        .toJson()
        .values
        .toList()
        .map((e) => e["Hadir"])
        .elementAt(widget.selectedIndex);
    final alpa = manager.kehadiranNew.meta!
        .toJson()
        .values
        .toList()
        .map((e) => e["Alpa"])
        .elementAt(widget.selectedIndex);
    final sakit = manager.kehadiranNew.meta!
        .toJson()
        .values
        .toList()
        .map((e) => e["Sakit"])
        .elementAt(widget.selectedIndex);
    final izin = manager.kehadiranNew.meta!
        .toJson()
        .values
        .toList()
        .map((e) => e["Izin"])
        .elementAt(widget.selectedIndex);
    final dispen = manager.kehadiranNew.meta!
        .toJson()
        .values
        .toList()
        .map((e) => e["Dispensasi"])
        .elementAt(widget.selectedIndex);
    var total = manager.kehadiranNew.meta!
        .toJson()
        .values
        .toList()
        .map((e) => e["Total"])
        .elementAt(widget.selectedIndex);

    List<DataKehadiran> kehadiran = [
      DataKehadiran("Hadir", hadir, "Hadir", AppTheme.primaryTheme),
      DataKehadiran("Alpa", alpa, "Alpa", AppTheme.absen),
      DataKehadiran("Sakit", sakit, "Sakit", AppTheme.absen),
      DataKehadiran("Izin", izin, "Izin", AppTheme.absen),
      DataKehadiran("Dispensasi", dispen, "Dispensasi", AppTheme.absen),
      DataKehadiran("", total > 16 ? 0 : total - 16, "Kosong", AppTheme.kosong),
    ];

    if (manager.state == DataState.initial) {
      return const LoadingMatkulCard();
    } else if (manager.state == DataState.loading) {
      return const LoadingMatkulCard();
    } else if (manager.state == DataState.error) {
      return const ErrorMatkulCards();
    }

    getWeeks(){
      var i = 0; 
      List<int> weeks = [];
      while(i<=112) { 
          if(i % 7 == 0){
            if(getWeeksForRange(afterTime, DateTime.now()).length >= i){
              weeks.add(i);
              // return weeks;
            }
          }
          i++;
          // weeks.add(i);
      }
      // print(weeks);
      return weeks;
    }

    getPercent1() {
      double percent = manager.kehadiranNew.meta!
              .toJson()
              .values
              .toList()
              .map((e) => e["Total"])
              .reduce((value, element) => (value + element)) /
          64 *
          100;
      return percent
          .toStringAsFixed(percent.truncateToDouble() == percent ? 0 : 2);
    }

    getPercent2() {
      double percent = manager.kehadiranNew.meta!
              .toJson()
              .values
              .toList()
              .map((e) => e["Total"])
              .elementAt(widget.selectedIndex) /
          17 *
          100;
      return percent
          .toStringAsFixed(percent.truncateToDouble() == percent ? 0 : 2);
    }

    return widget.diagram == false
        ? CircularPercentIndicator(
            startAngle: 90,
            radius: 105.0,
            animation: true,
            animationDuration: 1200,
            lineWidth: 15.0,
            percent: manager.kehadiranNew.meta!
                    .toJson()
                    .values
                    .toList()
                    .map((e) => e["Total"])
                    .reduce((value, element) => (value + element)) /
                64,
            center: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${getPercent1()} %",
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
                    "Minggu ke-${getWeeks().length}",
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
        : SfCircularChart(
            annotations: <CircularChartAnnotation>[
              CircularChartAnnotation(
                  widget: Text(
                '${getPercent2()}%',
                style: AppTextStyle.poppinsTextStyle(
                    color: AppTheme.black,
                    fontSize: 40,
                    fontsWeight: FontWeight.w700),
              )),
            ],
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <DoughnutSeries<DataKehadiran, String>>[
              DoughnutSeries<DataKehadiran, String>(
                radius: '150',
                innerRadius: '110',
                emptyPointSettings:
                    EmptyPointSettings(color: Colors.grey, borderWidth: 20),
                pointColorMapper: (datum, index) => datum.color,
                startAngle: 90,
                endAngle: 450,
                explode: true,
                dataSource: kehadiran,
                xValueMapper: (DataKehadiran data, index) => data.xData,
                yValueMapper: (DataKehadiran data, index) => data.yData,
              ),
            ]);
  }
}
