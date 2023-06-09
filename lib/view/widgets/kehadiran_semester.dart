import 'package:flutter/material.dart';
import 'package:presencee/theme/constant.dart';

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
                  onPressed: () => Navigator.of(context).pushNamed('/history/semester_history'),
                  child: Text(
                    'Lihat Semua',
                    style: AppTextStyle.poppinsTextStyle(
                      color: AppTheme.white,
                      fontSize: 14,
                      fontsWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
