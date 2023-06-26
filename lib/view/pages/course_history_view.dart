import 'package:presencee/model/riwayat_kehadiran_model.dart';
import 'package:presencee/view/widgets/diagram_history.dart';
import 'package:presencee/view/widgets/header_history.dart';
import 'package:presencee/view/widgets/list_history.dart';
import 'package:presencee/view_model/absensi_view_model.dart';
import 'package:presencee/view_model/dosen_view_model.dart';
import 'package:presencee/view_model/jadwal_view_model.dart';
import 'package:provider/provider.dart';
import '../../view_model/kehadiran_view_model.dart';
import 'package:flutter/material.dart';
import '../../theme/constant.dart';

class CourseHistory extends StatefulWidget {
  final JadwalViewModel manager;
  final int selectedIndex;
  final int idJadwal;

  const CourseHistory(
      {Key? key,
      required this.manager,
      // required this.managerDosen,
      required this.selectedIndex,
      required this.idJadwal})
      : super(key: key);

  @override
  State<CourseHistory> createState() => _CourseHistoryState();
}

class _CourseHistoryState extends State<CourseHistory> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(120),
          child: HeaderHistory(),
        ),
        body: Column(
          children: [
            const SizedBox(height: 37),
            Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.manager.jadwals[widget.selectedIndex].name.toString(),
                        style: AppTextStyle.poppinsTextStyle(
                            color: AppTheme.black,
                            fontsWeight: FontWeight.w600,
                            fontSize: 24),
                      ),
                      Text(
                        widget.manager.jadwals[widget.selectedIndex].dosen!.name.toString(),
                        style: AppTextStyle.poppinsTextStyle(
                            color: AppTheme.black,
                            fontsWeight: FontWeight.w400,
                            fontSize: 20),
                      ),
                    ],
                  ),
                )),
            Flexible(
              flex: 8,
              child: TabBarView(
                children: [
                  ListHistory(idJadwal: widget.idJadwal),
                  DiagramHistory(
                    manager: Provider.of<KehadiranViewModel>(context),
                    selectedIndex: widget.selectedIndex,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
