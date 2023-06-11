import 'package:flutter/material.dart';
import 'package:presencee/theme/constant.dart';
import '../pages/presence_view.dart';

// ignore: must_be_immutable
class CardAbsensi extends StatelessWidget {
  CardAbsensi({super.key, required this.Matkul, required this.hari, required this.jam});

  bool isTodayPresent = true;
  String? Matkul;
  String? hari;
  String? jam;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        splashColor: AppTheme.primaryTheme.withOpacity(0.2),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        onTap: () => Navigator.of(context).pushNamed('/schedule/presence'),
        title: Text(
          Matkul!,
          style: AppTextStyle.poppinsTextStyle(
            color: AppTheme.black,
            fontsWeight: FontWeight.w500,
            fontSize: 16,
          )
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 2),
            Text(
              hari!,
              style: AppTextStyle.poppinsTextStyle(
                color: AppTheme.gray_5,
                fontsWeight: FontWeight.w400,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              jam!,
              style: AppTextStyle.poppinsTextStyle(
                color: AppTheme.gray_5,
                fontsWeight: FontWeight.w400,
                fontSize: 13,
              ),
            ),
          ],
        ),
        trailing: Container(
          margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.005),
          height: 30,
          child: ElevatedButton(
            onPressed: () => Navigator.of(context).pushNamed('/schedule/presence'),
            style: ElevatedButton.styleFrom(
              backgroundColor: isTodayPresent ? AppTheme.primaryTheme : AppTheme.primaryTheme_3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: Text(
              'Presensi',
              style: AppTextStyle.poppinsTextStyle(
                color: AppTheme.white,
                fontsWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
        )
      ),
    );
  }
}
