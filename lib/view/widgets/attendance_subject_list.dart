import 'package:flutter/material.dart';
import '../../theme/constant.dart';

class AttendanceSubsList extends StatelessWidget {
  final String mataKuliah, tanggalHadir, statusHadir;
  final ScrollController? scrollControllers;
  final int total;

  const AttendanceSubsList({
    super.key, 
    required this.total,
    required this.mataKuliah, 
    required this.tanggalHadir, 
    required this.statusHadir,
    this.scrollControllers,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: scrollControllers,
      separatorBuilder: (context, index) => const Divider(),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: total,
      itemBuilder: (context, index) {
        return SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mataKuliah,
                      style: AppTextStyle.poppinsTextStyle(
                        color: AppTheme.black,
                        fontsWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      tanggalHadir,
                      style: AppTextStyle.poppinsTextStyle(
                        color: AppTheme.black_3,
                        fontsWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
                Container(
                  height: 30,
                  width: 125,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryTheme_2,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      statusHadir,
                      style: AppTextStyle.poppinsTextStyle(
                        color: AppTheme.white,
                        fontsWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}