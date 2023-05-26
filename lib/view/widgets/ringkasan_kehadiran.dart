import 'package:flutter/material.dart';
import 'package:presencee/theme/constant.dart';

class RingkasanKehadiran extends StatelessWidget {
  const RingkasanKehadiran({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 44, left: 24, right: 24),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Ringkasan kehadiran',
                style: AppTextStyle.poppinsTextStyle(
                  color: AppTheme.black,
                  fontSize: 18,
                  fontsWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 25,
                width: 90,
                decoration: BoxDecoration(
                  color: AppTheme.primaryTheme_2,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    'Mingguan',
                    style: AppTextStyle.poppinsTextStyle(
                      color: AppTheme.white,
                      fontSize: 12,
                      fontsWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 19),
        ],
      ),
    );
  }
}
