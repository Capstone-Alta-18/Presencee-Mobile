import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presencee/provider/kehadiran_viewModel.dart';
import 'package:presencee/theme/constant.dart';
import 'package:presencee/view/pages/profile_view.dart';
import 'package:presencee/view/pages/schedule_view.dart';
import 'package:presencee/view/widgets/card_matkul.dart';
import 'package:presencee/view/widgets/header.dart';
import 'package:provider/provider.dart';
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
                children: [
                  // const SizedBox(height: 24),
                  ListView.builder(
                    physics: ScrollPhysics(),
                    itemCount: manager.kehadiran.length,
                    shrinkWrap: true,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: InkWell(
                            splashColor: AppTheme.primaryTheme.withOpacity(0.4),
                            onTap: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  transitionDuration: const Duration(milliseconds: 500),
                                  pageBuilder: (context, animation, secondaryAnimation) => CourseHistory(
                                    manager: manager,
                                    selectedIndex: index,
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
                            child: SizedBox(
                              height: 128,
                              child: CardMatkul(
                                semester: true,
                                selectedIndex: index,
                                manager: manager,
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
