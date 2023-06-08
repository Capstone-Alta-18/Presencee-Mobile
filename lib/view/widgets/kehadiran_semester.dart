import 'package:flutter/material.dart';
import 'package:presencee/theme/constant.dart';
import 'package:presencee/view/pages/semester_attendance_history_view.dart';

class KehadiranSemester extends StatelessWidget {
  const KehadiranSemester({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 44, left: 24, right: 24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Kehadiran Semester ini',
                style: AppTextStyle.poppinsTextStyle(
                  color: AppTheme.black,
                  fontSize: 16,
                  fontsWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 30,
                width: 130,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 500),
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const SemesterHistory(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
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
                  child: Text(
                    'Lihat Semua',
                    style: AppTextStyle.poppinsTextStyle(
                      color: AppTheme.white,
                      fontSize: 14,
                      fontsWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
