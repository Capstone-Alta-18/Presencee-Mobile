import 'package:flutter/material.dart';
import 'package:presencee/theme/constant.dart';
import 'package:presencee/view/widgets/card_matkul.dart';
import 'package:presencee/view/widgets/header.dart';
import 'course_history_view.dart';

class SemesterHistory extends StatelessWidget {
  const SemesterHistory({super.key});

  @override
  Widget build(BuildContext context) {
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
                  const SizedBox(height: 24),
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      splashColor: AppTheme.primaryTheme.withOpacity(0.4),
                      onTap: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            transitionDuration:
                                const Duration(milliseconds: 500),
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const CourseHistory(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              var begin = Offset(1.0, 0.0);
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
                      child: const SizedBox(
                        height: 128,
                        child: CardMatkul(
                          semester: true,
                        ),
                      ),
                    ),
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
