import 'package:integration_test/common.dart';
import 'package:intl/intl.dart';
import 'package:presencee/model/riwayat_kehadiran_model.dart';
import 'package:presencee/view/widgets/diagram_history.dart';
import 'package:presencee/view/widgets/header_history.dart';
import 'package:presencee/view/widgets/list_history.dart';
import 'package:presencee/view_model/absensi_view_model.dart';
import 'package:presencee/view_model/app_view_model.dart';
import 'package:presencee/view_model/dosen_view_model.dart';
import 'package:presencee/view_model/jadwal_view_model.dart';
import 'package:presencee/view_model/mahasiswa_view_model.dart';
import 'package:presencee/view_model/user_view_model.dart';
import 'package:provider/provider.dart';
import '../../view_model/kehadiran_view_model.dart';
import 'package:flutter/material.dart';
import '../../theme/constant.dart';

class CourseHistory extends StatefulWidget {
  final String matkul;
  final String dosen;
  // final int selectedIndex;
  final int idJadwal;

  const CourseHistory(
      {Key? key,
      // required this.manager,
      // required this.managerDosen,
      // required this.selectedIndex,
      required this.matkul,
      required this.dosen,
      required this.idJadwal})
      : super(key: key);

  @override
  State<CourseHistory> createState() => _CourseHistoryState();
}

class _CourseHistoryState extends State<CourseHistory> {

  @override
  void initState() {
    print(widget.idJadwal);
    super.initState();
    var now = DateTime.utc(2023,06,19);
    var previousMonday = now.subtract(Duration(days: now.weekday - 1));
    var nextSaturday = previousMonday.add(Duration(days: 112));

    var after = DateFormat('yyyy-MM-ddT00:01:00+00:00').format(previousMonday);
    var before = DateFormat('yyyy-MM-ddT00:01:00+00:00').format(nextSaturday);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // final dataMahasiswa = Provider.of<MahasiswaViewModel>(context, listen: false);
      final user = Provider.of<UserViewModel>(context, listen: false).user!.data;
      Provider.of<KehadiranViewModel>(context,listen: false).getKehadiran(
        idMhs: user!.id!,
        afterTime: after,
        beforeTime: before,
        jadwalId: widget.idJadwal
      );
      print(user.id);
    });
  }
  @override
  Widget build(BuildContext context) {
    // final kehadiran = Provider.of<KehadiranViewModel>(context);
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
                        widget.matkul,
                        style: AppTextStyle.poppinsTextStyle(
                            color: AppTheme.black,
                            fontsWeight: FontWeight.w600,
                            fontSize: 24),
                      ),
                      Text(
                        widget.dosen,
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
                    idJadwal: widget.idJadwal,
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
