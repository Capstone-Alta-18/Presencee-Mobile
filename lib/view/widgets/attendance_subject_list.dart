import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:presencee/view_model/absensi_view_model.dart';
import 'package:presencee/view_model/mahasiswa_view_model.dart';
import 'package:provider/provider.dart';
import '../../theme/constant.dart';

class AttendanceSubsList extends StatefulWidget {
  // final String mataKuliah, tanggalHadir, statusHadir;
  final ScrollController? scrollControllers;
  // final int total;
  final int idJadwal;

  const AttendanceSubsList({
    super.key,
    // required this.total,
    // required this.mataKuliah,
    // required this.tanggalHadir,
    // required this.statusHadir,
    this.scrollControllers,
    required this.idJadwal,
  });

  @override
  State<AttendanceSubsList> createState() => _AttendanceSubsListState();
}

class _AttendanceSubsListState extends State<AttendanceSubsList> {
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final dataMahasiswa =
          Provider.of<MahasiswaViewModel>(context, listen: false);
      var now = DateTime.now();
      var previousMonday = now.subtract(Duration(days: now.weekday - 1));
      var nextSaturday = previousMonday.add(Duration(days: 6));
      var createdAfter =
          DateFormat('yyyy-MM-ddT00:00:00+00:00').format(previousMonday);
      var createdBefore =
          DateFormat('yyyy-MM-ddT23:59:00+00:00').format(nextSaturday);
      await Provider.of<AbsensiViewModel>(context, listen: false).getAbsen(
          userId: dataMahasiswa.mahasiswaSingle.userId ?? 0,
          mahasiswaId: dataMahasiswa.mahasiswaSingle.id ?? 0,
          jadwalId: widget.idJadwal,
          createdAfter: createdAfter,
          createdBefore: createdBefore);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AbsensiViewModel>(
        builder: ((context, value, child) => value.listAbsensi.isEmpty
                ? Center(
                    child: Text('Tidak ada riwayat absensi',
                        style: AppTextStyle.poppinsTextStyle(
                          color: AppTheme.black,
                          fontsWeight: FontWeight.w500,
                          fontSize: 16,
                        )),
                  )
                : ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      ListView.separated(
                        controller: widget.scrollControllers,
                        separatorBuilder: (context, index) => const Divider(),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: value.listAbsensi.take(6).length,
                        itemBuilder: (context, index) {
                          final absenView = value.listAbsensi[index];
                          return SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 24, right: 24),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        // widget.mataKuliah,
                                        absenView.matakuliah ?? '',
                                        style: AppTextStyle.poppinsTextStyle(
                                          color: AppTheme.black,
                                          fontsWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        // widget.tanggalHadir,
                                        '${absenView.status} : ${DateFormat('dd MMMM', 'id').format(DateTime.parse(absenView.timeAttemp.toString()))}',
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
                                      child: absenView.isKonfirmasi == false
                                          ? Text(
                                              // widget.statusHadir,
                                              'Belum Terkonfirmasi',
                                              style:
                                                  AppTextStyle.poppinsTextStyle(
                                                color: AppTheme.white,
                                                fontsWeight: FontWeight.w400,
                                                fontSize: 12,
                                              ),
                                            )
                                          : Text(
                                              // widget.statusHadir,
                                              'Terkonfirmasi',
                                              style:
                                                  AppTextStyle.poppinsTextStyle(
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
                      ),
                      const Divider(),
                      // const SizedBox(height: 10),
                      if (value.listAbsensi.length > 6)
                        Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.primaryTheme,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                              child: Text(
                                'Lihat Semua',
                                style: AppTextStyle.poppinsTextStyle(
                                  color: AppTheme.white,
                                  fontSize: 14,
                                  fontsWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  )
            // }
            ));
  }
}
