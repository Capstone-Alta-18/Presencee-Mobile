import 'package:flutter/material.dart';
import 'package:presencee/view/widgets/bar_chart.dart';
import 'package:presencee/view/widgets/card_matkul.dart';
import 'package:presencee/view/widgets/header.dart';
import 'package:presencee/view/widgets/kehadiran_semester.dart';
import 'package:presencee/view/widgets/persentase_kehadiran.dart';
import 'package:presencee/view/widgets/ringkasan_kehadiran.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Header(
              title: 'Riwayat Kehadiran',
              subtitle: 'Semester 2022/2', back: false,
            ),
            Container(
              margin: const EdgeInsets.only(top: 75, left: 95, right: 95),
              child: const PersentaseKehadiran(diagram: false,),
            ),
            const KehadiranSemester(),
            const CardMatkul(),
            const RingkasanKehadiran(),
            BarChartWidget(),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
