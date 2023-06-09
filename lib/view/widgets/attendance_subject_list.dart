import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:presencee/model/API/jadwal_api.dart';
import 'package:presencee/view/pages/course_history_view.dart';
import 'package:presencee/view_model/absensi_view_model.dart';
import 'package:presencee/view_model/jadwal_view_model.dart';
import 'package:presencee/view_model/mahasiswa_view_model.dart';
import 'package:presencee/view_model/user_view_model.dart';
import 'package:provider/provider.dart';
import '../../theme/constant.dart';

class AttendanceSubsList extends StatefulWidget {
  final ScrollController? scrollControllers;
  final String? matkul;
  final String? dosen;
  final int idJadwal;
  final bool subsList;

  const AttendanceSubsList(
      {super.key,
      this.scrollControllers,
      this.matkul,
      this.dosen,
      required this.idJadwal,
      required this.subsList});

  @override
  State<AttendanceSubsList> createState() => _AttendanceSubsListState();
}

class _AttendanceSubsListState extends State<AttendanceSubsList> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final dataMahasiswa =
          Provider.of<MahasiswaViewModel>(context, listen: false);
      var now = DateTime.utc(2023, 06, 19);
      var previousMonday = now.subtract(Duration(days: now.weekday - 1));
      var nextSaturday = previousMonday.add(const Duration(days: 112));
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
    final manager = Provider.of<AbsensiViewModel>(context);
    if (manager.state == DataState.initial) {
      return const Center();
    } else if (manager.state == DataState.loading) {
      return const Center();
    } else if (manager.state == DataState.error) {
      return Center(
        child: Text(
          "Tidak ada riwayat absensi",
          style: AppTextStyle.poppinsTextStyle(
              fontSize: 20, fontsWeight: FontWeight.w600),
        ),
      );
    }
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
                  widget.subsList == true
                      ? ListView.separated(
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
                                          absenView.matakuliah ?? '',
                                          style: AppTextStyle.poppinsTextStyle(
                                            color: AppTheme.black,
                                            fontsWeight: FontWeight.w600,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
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
                                                'Belum Terkonfirmasi',
                                                style: AppTextStyle
                                                    .poppinsTextStyle(
                                                  color: AppTheme.white,
                                                  fontsWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                ),
                                              )
                                            : Text(
                                                'Terkonfirmasi',
                                                style: AppTextStyle
                                                    .poppinsTextStyle(
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
                        )
                      : ListView.separated(
                          controller: widget.scrollControllers,
                          separatorBuilder: (context, index) => const Divider(),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: value.listAbsensi.length,
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
                                          absenView.matakuliah ?? '',
                                          style: AppTextStyle.poppinsTextStyle(
                                            color: AppTheme.black,
                                            fontsWeight: FontWeight.w600,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          '${absenView.status} : ${DateFormat('dd MMMM', 'id').format(DateTime.parse(absenView.timeAttemp.toString()))}',
                                          style: AppTextStyle.poppinsTextStyle(
                                            color: AppTheme.black_3,
                                            fontsWeight: FontWeight.w400,
                                            fontSize: 12,
                                          ),
                                        )
                                      ],
                                    ),
                                    absenView.isKonfirmasi == true
                                        ? Container(
                                            height: 30,
                                            width: 125,
                                            decoration: BoxDecoration(
                                              color: AppTheme.primaryTheme_2,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Center(
                                                child: Text(
                                              'Terkonfirmasi',
                                              style:
                                                  AppTextStyle.poppinsTextStyle(
                                                color: AppTheme.white,
                                                fontsWeight: FontWeight.w400,
                                                fontSize: 12,
                                              ),
                                            )),
                                          )
                                        : Container(
                                            height: 30,
                                            width: 125,
                                            decoration: BoxDecoration(
                                              color: AppTheme.gray_2,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Center(
                                                child: Text(
                                              'Belum Terkonfirmasi',
                                              style:
                                                  AppTextStyle.poppinsTextStyle(
                                                color: AppTheme.white,
                                                fontsWeight: FontWeight.w400,
                                                fontSize: 12,
                                              ),
                                            )),
                                          )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                  const Divider(),
                  if (widget.subsList == true)
                    if (value.listAbsensi.length > 6)
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  transitionDuration:
                                      const Duration(milliseconds: 500),
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      CourseHistory(
                                    // matkul: widget.matkul ?? '',
                                    // dosen: widget.dosen ?? '',
                                    matkul: "Akuntansi",
                                    dosen: "Pak Dosen",
                                    idJadwal: widget.idJadwal,
                                  ),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    var begin = const Offset(1.0, 0.0);
                                    var end = Offset.zero;
                                    var curve = Curves.ease;
                                    var tween = Tween(begin: begin, end: end)
                                        .chain(CurveTween(curve: curve));

                                    return SlideTransition(
                                      position: animation.drive(tween),
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            },
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
              )));
  }
}
