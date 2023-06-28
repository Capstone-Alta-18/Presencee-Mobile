import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:presencee/model/riwayat_dashboard.dart';
import 'package:presencee/model/riwayat_kehadiran_model.dart';
import 'package:presencee/theme/constant.dart';
import 'package:presencee/view/pages/course_history_view.dart';
import 'package:presencee/view/widgets/card_matkul.dart';
import 'package:presencee/view/widgets/header.dart';
import 'package:presencee/view/widgets/persentase_kehadiran.dart';
import 'package:presencee/view_model/app_view_model.dart';
import 'package:presencee/view_model/dosen_view_model.dart';
import 'package:presencee/view_model/jadwal_view_model.dart';
import 'package:presencee/view_model/kehadiran_view_model.dart';
import 'package:presencee/view_model/mahasiswa_view_model.dart';
import 'package:presencee/view_model/user_view_model.dart';
import "package:provider/provider.dart";
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:presencee/view/widgets/state_status_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DataKehadiran {
  DataKehadiran(this.xData, this.yData, this.text, this.color);
  final String xData;
  final num yData;
  final String text;
  final Color color;
}

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final mahasiswa = Provider.of<MahasiswaViewModel>(context, listen: false)
          .mahasiswaSingle;
      var now = DateTime.now();
      var jadwal = DateTime.utc(2023, 06, 18);
      var jamAfter = DateFormat('yyyy-MM-ddT00:01:00+00:00').format(now);
      var jamBefore = DateFormat('yyyy-MM-ddT23:59:00+00:00').format(now);
      var previousMonday = jadwal.subtract(Duration(days: jadwal.weekday - 1));
      var nextSaturday = previousMonday.add(const Duration(days: 112));
      var createdAfter =
          DateFormat('yyyy-MM-ddT00:01:00+00:00').format(previousMonday);
      var createdBefore =
          DateFormat('yyyy-MM-ddT23:59:00+00:00').format(nextSaturday);
      Provider.of<KehadiranViewModel>(context, listen: false).getKehadiranNew(
          idMhs: mahasiswa.userId ?? 0,
          afterTime: createdAfter,
          beforeTime: createdBefore);
      Provider.of<KehadiranViewModel>(context, listen: false).getKehadiran(
        idMhs: mahasiswa.userId ?? 0,
        afterTime: createdAfter,
        beforeTime: createdBefore,
        jadwalId: 3267043513,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final manager = Provider.of<KehadiranViewModel>(context);
    final jadwal = Provider.of<JadwalViewModel>(context);

    if (manager.state == DataState.initial) {
      return const LoadingSemesterHistoryCard();
    } else if (manager.state == DataState.loading) {
      return const LoadingSemesterHistoryCard();
    } else if (manager.state == DataState.error) {
      return Center(
        child: Text(
          "Terjadi Kesalahan",
          style: AppTextStyle.poppinsTextStyle(
              fontSize: 30,
              fontsWeight: FontWeight.w600,
              color: AppTheme.primaryTheme),
        ),
      );
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Header(
              title: 'Riwayat Kehadiran',
              subtitle: 'Semester 2023/2',
              back: false,
            ),
            jadwal.jadwals.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(padding: EdgeInsets.only(bottom: 55)),
                        const Center(
                          child: PersentaseKehadiran(
                            diagram: false,
                            selectedIndex: 0,
                            idJadwal: 0,
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(bottom: 43)),
                        Text(
                          "Kehadiran Per Mata Kuliah",
                          textAlign: TextAlign.start,
                          style: AppTextStyle.poppinsTextStyle(
                              fontSize: 18, fontsWeight: FontWeight.w600),
                        ),
                        ListView.builder(
                          physics: const ScrollPhysics(),
                          itemCount: jadwal.jadwals.length,
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          itemBuilder: ((context, index) {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              child: FadeInAnimation(
                                curve: Curves.easeInCubic,
                                duration: const Duration(milliseconds: 700),
                                child: Card(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: InkWell(
                                    splashColor:
                                        AppTheme.primaryTheme.withOpacity(0.4),
                                    onTap: () {
                                      Navigator.of(context).push(
                                        PageRouteBuilder(
                                          transitionDuration:
                                              const Duration(milliseconds: 500),
                                          pageBuilder: (context, animation,
                                                  secondaryAnimation) =>
                                              CourseHistory(
                                            matkul: jadwal.jadwals[index].name!,
                                            dosen: jadwal
                                                .jadwals[index].dosen!.name!,
                                            idJadwal: jadwal.jadwals[index].id!,
                                          ),
                                          transitionsBuilder: (context,
                                              animation,
                                              secondaryAnimation,
                                              child) {
                                            var begin = const Offset(1.0, 0.0);
                                            var end = Offset.zero;
                                            var curve = Curves.ease;
                                            var tween = Tween(
                                                    begin: begin, end: end)
                                                .chain(
                                                    CurveTween(curve: curve));

                                            return SlideTransition(
                                              position: animation.drive(tween),
                                              child: child,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    child: SizedBox(
                                      height: 128,
                                      child: CardMatkul(
                                        semester: true,
                                        selectedIndex: index,
                                        idJadwal: jadwal.jadwals[index].id ?? 0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ))
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Tidak ada Riwayat Absen",
                          style: AppTextStyle.poppinsTextStyle(
                              fontSize: 20, fontsWeight: FontWeight.w600),
                        ),
                      ],
                    )),
                  ),
          ],
        ),
      ),
    );
  }
}
