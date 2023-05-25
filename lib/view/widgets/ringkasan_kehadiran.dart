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
                  fontsWeight: FontWeight.w600
                )
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 30,
                width: 112,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))
                    ),
                    elevation: MaterialStateProperty.all<double>(0),
                    backgroundColor: MaterialStateProperty.all<Color>(AppTheme.primaryTheme_3)
                  ),
                  onPressed: () {},
                  child: Text(
                    'Mingguan',
                    style: AppTextStyle.poppinsTextStyle(
                      color: AppTheme.white,
                      fontSize: 14,
                      fontsWeight: FontWeight.w400
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}