import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:presencee/view/widgets/persentase_kehadiran.dart';
import 'package:presencee/view/widgets/state_status_widget.dart';
import 'package:presencee/view_model/dosen_view_model.dart';
import 'package:presencee/view_model/kehadiran_view_model.dart';
import 'package:presencee/view/widgets/card_matkul.dart';
import 'package:presencee/view/widgets/header.dart';
import 'package:presencee/theme/constant.dart';
import 'package:presencee/view_model/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'course_history_view.dart';

class SemesterHistory extends StatefulWidget {
  const SemesterHistory({super.key});

  @override
  State<SemesterHistory> createState() => _SemesterHistoryState();
}

class _SemesterHistoryState extends State<SemesterHistory> {
  @override
  Widget build(BuildContext context) {
    final manager = Provider.of<KehadiranViewModel>(context);
    final managerDosen = Provider.of<DosenViewModel>(context);

    if (manager.state == DataState.initial) {
      return const LoadingSemesterHistoryCard();
    } else if (manager.state == DataState.loading) {
      return const LoadingSemesterHistoryCard();
    } else if (manager.state == DataState.error) {
      return const ErrorSemesterHistoryCard();
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Header(
              title: 'Riwayat Kehadiran',
              subtitle: 'Semester 2022/2',
              back: true,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(padding: EdgeInsets.only(bottom: 55)),
                  const Center(
                    child: PersentaseKehadiran(
                      diagram: false,
                      selectedIndex: 0,
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
                    itemCount: manager.kehadiranNew.meta!.toJson().length,
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
                                      manager: manager,
                                      selectedIndex: index,
                                      managerDosen: managerDosen,
                                      idJadwal: 1,
                                    ),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      var begin = const Offset(1.0, 0.0);
                                      var end = Offset.zero;
                                      var curve = Curves.ease;
                                      var tween = Tween(begin: begin, end: end)
                                          .chain(CurveTween(curve: curve));

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
                                  idJadwal: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
