import 'package:flutter/material.dart';
import 'package:presencee/theme/constant.dart';
import 'package:presencee/view/widgets/card_matkul.dart';

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
              const Text(
                'Kehadiran Semester ini',
                style: TextStyle(
                  color: Color.fromRGBO(36, 36, 36, 1),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 30,
                width: 130,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/semester_history');
                  },
                  child: const Text(
                    'Lihat Semua',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 19),
          const SizedBox(
            width: 114,
            height: 128,
            child: Card(
                elevation: 2,
                child: CardMatkul(
                  semester: false,
                )),
          ),
        ],
      ),
    );
  }
}
