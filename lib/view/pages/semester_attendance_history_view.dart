import 'package:flutter/material.dart';
import 'package:presencee/view/widgets/card_matkul.dart';
import 'package:presencee/view/widgets/header.dart';

class SemesterHistory extends StatelessWidget {
  const SemesterHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Header(
              title: 'Riwayat Kehadiran',
              subtitle: 'Semester 2022/2', back: true,
            ),
            SizedBox(height: 24),
            Padding(
              padding: EdgeInsets.only(left: 24, right: 24),
              child: SizedBox(
                height: 125,
                child: Card(
                  elevation: 2,
                  child: CardMatkul(
                    semester: true,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
