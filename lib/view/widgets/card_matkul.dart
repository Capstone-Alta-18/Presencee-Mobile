import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:presencee/model/riwayat_kehadiran_model.dart';
import 'package:presencee/theme/constant.dart';
import 'package:presencee/view/pages/course_history_view.dart';
import 'package:presencee/view/pages/history_view.dart';
import 'package:presencee/view/widgets/state_status_widget.dart';
import 'package:presencee/view_model/dosen_view_model.dart';
import 'package:presencee/view_model/kehadiran_view_model.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CardMatkul extends StatefulWidget {
  final bool semester;
  final int selectedIndex;
  // final KehadiranViewModel manager;

  const CardMatkul({
    super.key,
    required this.semester,
    required this.selectedIndex,
    // required this.manager,
  });

  @override
  State<CardMatkul> createState() => _CardMatkulState();
}

class _CardMatkulState extends State<CardMatkul> {

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   Provider.of<DosenViewModel>(context, listen: false).getDosenModel();
    // });
  }

  @override
  Widget build(BuildContext context) {
    final manager = Provider.of<KehadiranViewModel>(context);
    final managerDosen = Provider.of<DosenViewModel>(context);

    final hadir = manager.kehadiranNew.meta!.toJson().values.toList().map((e) => e["Hadir"]).elementAt(widget.selectedIndex);
    final alpa = manager.kehadiranNew.meta!.toJson().values.toList().map((e) => e["Alpa"]).elementAt(widget.selectedIndex);
    final sakit = manager.kehadiranNew.meta!.toJson().values.toList().map((e) => e["Sakit"]).elementAt(widget.selectedIndex);
    final izin = manager.kehadiranNew.meta!.toJson().values.toList().map((e) => e["Izin"]).elementAt(widget.selectedIndex);
    final dispen = manager.kehadiranNew.meta!.toJson().values.toList().map((e) => e["Dispensasi"]).elementAt(widget.selectedIndex);
    var total = manager.kehadiranNew.meta!.toJson().values.toList().map((e) => e["Total"]).elementAt(widget.selectedIndex);

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

    Color cardColor(int selectedIndex){
      // if (manager.kehadiran[selectedIndex].kodeMatkul.toString() == "MU"){
      if (selectedIndex <= 1){
        return AppTheme.greenCard;
      } else {
        return AppTheme.purpleCard;
      }
    }
    return widget.semester == false
        ? SizedBox(
            height: 164,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: manager.kehadiranNew.meta!.toJson().length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: FadeInAnimation(
                    // curve: Curves.easeInOut,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18),
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        child: InkWell(
                          onTap: () {
                            // var manager = Provider.of<KehadiranViewModel>(context, listen: false);
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  const begin = Offset(0.0, 1.0);
                                  const end = Offset.zero;
                                  var tween = Tween(begin: begin, end: end)
                                      .chain(CurveTween(curve: Curves.ease));
                                  return SlideTransition(
                                    position: animation.drive(tween),
                                    child: child,
                                  );
                                },
                                pageBuilder: (context, animation, secondaryAnimation) => CourseHistory(manager: manager, selectedIndex: index,managerDosen: managerDosen,),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
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
                                    percent: manager.kehadiranNew.meta!.toJson().values.toList().map((e) => e["Total"]).elementAt(index) / 20,
                                    // percent: 0.8,
                                    // percent: manager.kehadiran[index].kehadiran![0].toJson().values.reduce((value, element) => value + element) / 16.0,
                                    // startAngle: 0.5,
                                    center: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: cardColor(index),
                                          // color: manager.kehadiran[index].kodeMatkul == "MU" ? AppTheme.greenCard : AppTheme.purpleCard,
                                          shape: BoxShape.circle),
                                      child: Center(
                                        child: Text(
                                          // "${manager.kehadiran[index].kodeMatkul}",
                                          "MU",
                                          style: AppTextStyle.poppinsTextStyle(
                                            color: AppTheme.black,
                                            fontSize: 22,
                                            fontsWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                    backgroundColor: AppTheme.gray,
                                    progressColor: AppTheme.primaryTheme,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    manager.kehadiranNew.meta!.toJson().keys.toList()[index].toString(),
                                    style: AppTextStyle.poppinsTextStyle(
                                      color: AppTheme.black,
                                      fontSize: 14,
                                      fontsWeight: FontWeight.w600,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
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
                padding: const EdgeInsets.only(left: 0.0),
                child: SizedBox(
                  width: 100,
                  child: SfCircularChart(
                    // borderColor: Colors.amber,
                    // centerX: '30',
                    annotations: <CircularChartAnnotation>[
                        CircularChartAnnotation(
                            widget: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: cardColor(widget.selectedIndex),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  widget.selectedIndex > 1 ? "EE" : "MU",
                                  // manager.kehadiran[widget.selectedIndex].kodeMatkul.toString(),
                                  style: AppTextStyle.poppinsTextStyle(
                                      color: AppTheme.black,
                                      fontSize: 22,
                                      fontsWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                      ],
                      // tooltipBehavior: TooltipBehavior(enable: true),
                      series: <DoughnutSeries<DataKehadiran, String>>[
                          DoughnutSeries<DataKehadiran, String>(
                            radius: '40',
                            innerRadius: '33',
                            emptyPointSettings:
                                EmptyPointSettings(color: Colors.grey, borderWidth: 20),
                            pointColorMapper: (datum, index) => datum.color,
                            startAngle: 90,
                            endAngle: 450,
                            explode: false,
                            // explodeIndex: 0,
                            dataSource: kehadiran,
                            xValueMapper: (DataKehadiran data, index) => data.xData,
                            yValueMapper: (DataKehadiran data, index) => data.yData,
                            // dataLabelMapper: (DataKehadiran data, _) => data.text,
                            // dataLabelSettings: DataLabelSettings(isVisible: true)
                          ),
                        ]
                  ),
                )
                // child: CircularPercentIndicator(
                //   radius: 40.0,
                //   animation: true,
                //   animationDuration: 1200,
                //   lineWidth: 7.0,
                //   percent: manager.kehadiranNew.meta!.toJson().values.toList().map((e) => e["Total"]).elementAt(widget.selectedIndex) / 20,
                //   // percent : 0.8,
                //   // percent: manager.kehadiran[widget.selectedIndex].kehadiran![0].toJson().values.reduce((value, element) => value + element) / 16.0,
                //   // startAngle: 0.5,
                //   center: Container(
                //     width: 50,
                //     height: 50,
                //     decoration: BoxDecoration(
                //       color: cardColor(widget.selectedIndex),
                //       shape: BoxShape.circle,
                //     ),
                //     child: Center(
                //       child: Text(
                //         "MU",
                //         // manager.kehadiran[widget.selectedIndex].kodeMatkul.toString(),
                //         style: AppTextStyle.poppinsTextStyle(
                //             color: AppTheme.black,
                //             fontSize: 22,
                //             fontsWeight: FontWeight.w600),
                //       ),
                //     ),
                //   ),
                //   backgroundColor: AppTheme.gray,
                //   progressColor: AppTheme.primaryTheme,
                // ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        manager.kehadiranNew.meta!.toJson().keys.toList()[widget.selectedIndex].toString(),
                        style: AppTextStyle.poppinsTextStyle(
                          color: AppTheme.black,
                          fontSize: 16,
                          fontsWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        managerDosen.dosen.dosens![widget.selectedIndex].name.toString(),
                        // manager.kehadiranNew.meta!.bahasaIndonesia!.total.toString(),
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
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 500),
                      pageBuilder: (context, animation, secondaryAnimation) => CourseHistory(
                        manager: manager,
                        selectedIndex: widget.selectedIndex,
                        managerDosen: managerDosen,
                      ),
                      transitionsBuilder: (context, animation,
                        secondaryAnimation, child) {
                        var begin = const Offset(1.0, 0.0);
                        var end = Offset.zero;
                        var curve = Curves.ease;
                        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                              
                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    ),
                  );
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
