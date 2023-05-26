import 'package:flutter/material.dart';
import 'package:presencee/theme/constant.dart';

// ignore: must_be_immutable
class CardAbsensi extends StatelessWidget {
  CardAbsensi(
      {super.key, required this.Matkul, required this.hari, required this.jam});

  bool isTodayPrecens = true;

  String? Matkul;

  String? hari;

  String? jam;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 24, right: 24),
      child: GestureDetector(
        onTap: () {
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => """DetailMatkul()"""));
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: AppTheme.gray_5),
              borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 8, bottom: 8, left: 18, right: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Matkul!,
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 2),
                    Text(hari!,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey)),
                    SizedBox(height: 2),
                    Text(jam!,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey)),
                  ],
                )),
                GestureDetector(
                  onTap: () {
                    //logika absensi
                  },
                  child: Container(
                      height: 22,
                      width: 68,
                      decoration: BoxDecoration(
                          color: isTodayPrecens
                              ? AppTheme.primaryTheme
                              : AppTheme.primaryTheme_3,
                          borderRadius: BorderRadius.circular(2)),
                      child: Center(
                        child: Text(
                          'Presensi',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              color: Colors.white),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
