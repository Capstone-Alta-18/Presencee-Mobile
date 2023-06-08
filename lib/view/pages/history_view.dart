import 'package:flutter/material.dart';
import 'package:presencee/provider/kehadiran_viewModel.dart';
import 'package:presencee/view/widgets/bar_chart.dart';
import 'package:presencee/view/widgets/card_matkul.dart';
import 'package:presencee/view/widgets/header.dart';
import 'package:presencee/view/widgets/kehadiran_semester.dart';
import 'package:presencee/view/widgets/persentase_kehadiran.dart';
import 'package:presencee/view/widgets/ringkasan_kehadiran.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) { 
      Provider.of<KehadiranViewModel>(context, listen: false).getKehadiran();
    });
  }

  @override
  Widget build(BuildContext context) {
    final manager = Provider.of<KehadiranViewModel>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Header(
              title: "Riwayat Kehadiran",
              subtitle: 'Semester 2022/2', back: false,
            ),
            Container(
              margin: const EdgeInsets.only(top: 75, left: 95, right: 95),
              child: PersentaseKehadiran(diagram: false,manager: manager,selectedIndex: 0,),
            ),
            const KehadiranSemester(),
            CardMatkul(semester: false,selectedIndex: 0,manager: manager,),
            const RingkasanKehadiran(),
            BarChartWidget(),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
