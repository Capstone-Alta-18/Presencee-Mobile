import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:presencee/theme/constant.dart';
import 'package:presencee/view/pages/history_view.dart';
import 'package:presencee/view/widgets/State_Status_widget.dart';
import 'package:presencee/view_model/absensi_view_model.dart';
import 'package:presencee/view_model/jadwal_view_model.dart';
import 'package:presencee/view_model/kehadiran_view_model.dart';
import 'package:presencee/theme/constant.dart';
import 'package:presencee/view_model/mahasiswa_view_model.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../view_model/user_view_model.dart';

class PersentaseKehadiran extends StatefulWidget {
  final bool diagram;
  final int selectedIndex;
  final int idJadwal;
  const PersentaseKehadiran(
      {super.key, required this.diagram, required this.selectedIndex,required this.idJadwal});

  @override
  State<PersentaseKehadiran> createState() => _PersentaseKehadiranState();
}

class _PersentaseKehadiranState extends State<PersentaseKehadiran> {
  var afterTime = DateTime.utc(2023,06,18);
  var beforeTime = DateTime.now();
  
  @override
  void initState() {
    super.initState();
    var now = DateTime.utc(2023,06,18);
    var previousMonday = now.subtract(Duration(days: now.weekday - 1));
    var nextSaturday = previousMonday.add(Duration(days: 112));

    var after = DateFormat('yyyy-MM-ddT00:01:00+00:00').format(previousMonday);
    var before = DateFormat('yyyy-MM-ddT00:01:00+00:00').format(nextSaturday);

    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   final user = Provider.of<UserViewModel>(context, listen: false).user!.data;
    //   Provider.of<KehadiranViewModel>(context,listen: false).getKehadiran(
    //     idMhs: user!.id!,
    //     afterTime: after,
    //     beforeTime: before,
    //     jadwalId: widget.idJadwal
    //   );
    // });
  }

  @override
  Widget build(BuildContext context) {
    
    final manager = Provider.of<KehadiranViewModel>(context);
    final jadwal = Provider.of<JadwalViewModel>(context);

    final hadir = manager.kehadiran.meta!.hadir!.toInt();
    final alpa = manager.kehadiran.meta!.alpa!.toInt();
    final sakit = manager.kehadiran.meta!.sakit!.toInt();
    final izin = manager.kehadiran.meta!.izin!.toInt();
    final dispen = manager.kehadiran.meta!.dispensasi!.toInt();
    final total = manager.kehadiran.totalCount!.toInt();
    

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
      var diff = beforeTime.difference(afterTime).inDays;
      var i = 0; 
      List<int> weeks = [];
      while(i<=112) { 
          if(i % 7 == 0){
            if(diff >= i){
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
      // double percent = manager.kehadiranNew.meta!
      //         .toJson()
      //         .values
      //         .toList()
      //         .map((e) => e["Total"])
      //         .reduce((value, element) => (value + element)) /
      //      (manager.kehadiranNew.meta!.toJson().length * 16) *
      //     100;
      double percent = manager.kehadiran.totalCount!.toDouble() / (jadwal.jadwals.length * 16) * 100;
      return percent
          .toStringAsFixed(percent.truncateToDouble() == percent ? 0 : 2);
    }

    getPercent2() {
      // double percent = manager.kehadiranNew.meta!
      //         .toJson()
      //         .values
      //         .toList()
      //         .map((e) => e["Total"])
      //         .elementAt(widget.selectedIndex) /
      //     16 *
      //     100;
      double percent = manager.kehadiran.totalCount!.toDouble() / 16 * 100;
      return percent > 100 ? 100 : percent
          .toStringAsFixed(percent.truncateToDouble() == percent ? 0 : 2);
    }

    return widget.diagram == false
        ? CircularPercentIndicator(
            startAngle: 90,
            radius: 105.0,
            animation: true,
            animationDuration: 1200,
            lineWidth: 15.0,
            // percent: 0.8,
            percent: manager.kehadiran.totalCount!.toDouble() / 48,
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
