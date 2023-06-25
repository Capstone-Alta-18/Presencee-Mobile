import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:intl/intl.dart';
import 'package:presencee/model/mahasiswa_model.dart';
import 'package:presencee/theme/constant.dart';
import 'package:presencee/view_model/absensi_view_model.dart';
import 'package:presencee/view_model/mahasiswa_view_model.dart';
import 'package:provider/provider.dart';

import 'alerted_attendance.dart';
import 'package:presencee/view_model/app_view_model.dart';

class CardPresence extends StatefulWidget {
  const CardPresence({
    super.key,
  });

  @override
  State<CardPresence> createState() => _CardPresenceState();
}

class _CardPresenceState extends State<CardPresence> {
  int? _selectedValue;
  String? location;
  String? address;
  Map absenData = {};
  Mahasiswas mahasiswa = Mahasiswas();
  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() {
    mahasiswa =
        Provider.of<MahasiswaViewModel>(context, listen: false).mahasiswaSingle;
    absenData = Provider.of<AppViewModel>(context, listen: false).dataAbsen;
    setState(() {});
  }

  void keteranganAbsen({required String status}) async {
    showDialog(
      context: context,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
    var now = DateTime.now().toString().split(' ');
    if (mounted) {
      await Provider.of<AbsensiViewModel>(context, listen: false).createAbsen(
          userId: mahasiswa.userId!,
          mahasiswaId: mahasiswa.id!,
          jadwalId: absenData['idJadwal'],
          timeAttemp: "${now[0]}T${now[1].split('.')[0]}+00:00",
          matakuliah: absenData['namaMatkul'],
          status: status,
          location: '',
          image: '');
      if (mounted) {
        Navigator.pop(context);

        if (Provider.of<AbsensiViewModel>(context, listen: false)
                .absensi
                ?.message ==
            'success creating absen') {
          var nows = DateTime.now();
          var previousMonday = nows.subtract(Duration(days: nows.weekday - 1));
          var nextSaturday = previousMonday.add(const Duration(days: 6));
          var createdAfter =
              DateFormat('yyyy-MM-ddT00:00:00+00:00').format(previousMonday);
          var createdBefore =
              DateFormat('yyyy-MM-ddT23:59:00+00:00').format(nextSaturday);

          await Provider.of<AbsensiViewModel>(context, listen: false).getAbsen(
              userId: mahasiswa.userId!,
              mahasiswaId: mahasiswa.id!,
              jadwalId: absenData['idJadwal'],
              createdAfter: createdAfter,
              createdBefore: createdBefore);
          if (mounted) {
            SnackbarAlertDialog().customDialogs(context,
                message: "Absensi berhasil",
                icons: PhosphorIcons.check_circle_fill,
                iconColor: AppTheme.success,
                backgroundsColor: AppTheme.white,
                durations: 1800);
          }
        } else if (Provider.of<AbsensiViewModel>(context, listen: false)
                    .absensi
                    ?.message ==
                'missing or malformed jwt' ||
            Provider.of<AbsensiViewModel>(context, listen: false)
                    .absensi
                    ?.message ==
                'invalid or expired jwt') {
          SnackbarAlertDialog().customDialogs(context,
              message: "Token telah kadaluarsa, harap login kembali",
              icons: PhosphorIcons.x_circle_fill,
              iconColor: AppTheme.error,
              backgroundsColor: AppTheme.white,
              durations: 1800);
        } else {
          SnackbarAlertDialog().customDialogs(context,
              message: "Absensi gagal",
              icons: PhosphorIcons.x_circle_fill,
              iconColor: AppTheme.error,
              backgroundsColor: AppTheme.white,
              durations: 1800);
        }
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final dataMahasiswa =
        Provider.of<MahasiswaViewModel>(context).mahasiswaSingle;
    return SizedBox(
      width: MediaQuery.of(context).size.width - 40,
      child: Card(
        color: AppTheme.primaryTheme_5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            const SizedBox(height: 24),
            Text(
              absenData['namaMatkul'],
              style: AppTextStyle.poppinsTextStyle(
                color: AppTheme.black,
                fontsWeight: FontWeight.w600,
                fontSize: 24,
              ),
            ),
            Text(
              '(${absenData['kodeKelas']})',
              style: AppTextStyle.poppinsTextStyle(
                color: AppTheme.black,
                fontsWeight: FontWeight.w600,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              absenData['namaDosen'],
              style: AppTextStyle.poppinsTextStyle(
                color: AppTheme.black_2,
                fontsWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              absenData['date'],
              style: AppTextStyle.poppinsTextStyle(
                color: AppTheme.black_2,
                fontsWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 30),
            Text(
              dataMahasiswa.name ?? '',
              style: AppTextStyle.poppinsTextStyle(
                color: AppTheme.black,
                fontsWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              dataMahasiswa.nim ?? '',
              style: AppTextStyle.poppinsTextStyle(
                color: AppTheme.black_3,
                fontsWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryTheme_5,
                    side: const BorderSide(
                      color: AppTheme.primaryTheme_2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return StatefulBuilder(
                          builder:
                              (BuildContext context, StateSetter setState) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              title: Text(
                                'Keterangan Absen',
                                style: AppTextStyle.poppinsTextStyle(
                                  color: AppTheme.black,
                                  fontSize: 24,
                                  fontsWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  RadioListTile(
                                    title: const Text('Sakit'),
                                    value: 1,
                                    groupValue: _selectedValue,
                                    onChanged: (int? value) {
                                      setState(() {
                                        _selectedValue = value;
                                      });
                                    },
                                  ),
                                  RadioListTile(
                                    title: const Text('Izin'),
                                    value: 2,
                                    groupValue: _selectedValue,
                                    onChanged: (int? value) {
                                      setState(() {
                                        _selectedValue = value;
                                      });
                                    },
                                  ),
                                  RadioListTile(
                                    title: const Text('Dispensasi'),
                                    value: 3,
                                    groupValue: _selectedValue,
                                    onChanged: (int? value) {
                                      setState(() {
                                        _selectedValue = value;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppTheme.white,
                                          side: const BorderSide(
                                            color: AppTheme.primaryTheme_2,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          _selectedValue = null;
                                        },
                                        child: Text(
                                          'Batal',
                                          style: AppTextStyle.poppinsTextStyle(
                                            color: AppTheme.primaryTheme,
                                            fontSize: 14,
                                            fontsWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppTheme.primaryTheme_2,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                          ),
                                        ),
                                        onPressed: () {
                                          if (_selectedValue == 1) {
                                            keteranganAbsen(status: 'Sakit');
                                          } else if (_selectedValue == 2) {
                                            keteranganAbsen(status: 'Izin');
                                          } else if (_selectedValue == 3) {
                                            keteranganAbsen(
                                                status: 'Dispensasi');
                                          }
                                        },
                                        child: Text(
                                          'Simpan',
                                          style: AppTextStyle.poppinsTextStyle(
                                            color: AppTheme.white,
                                            fontSize: 14,
                                            fontsWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  child: Text(
                    "Absen",
                    style: AppTextStyle.poppinsTextStyle(
                      fontsWeight: FontWeight.w500,
                      fontSize: 14,
                      color: AppTheme.primaryTheme,
                    ),
                  ),
                ),
                const SizedBox(width: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryTheme_2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                    disabledBackgroundColor: AppTheme.disabled,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          title: Text(
                            'Pilih metode Presensi',
                            style: AppTextStyle.poppinsTextStyle(
                              color: AppTheme.black,
                              fontSize: 24,
                              fontsWeight: FontWeight.w600,
                            ),
                          ),
                          content: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  onPressed: () => Navigator.pushNamed(
                                    context,
                                    '/schedule/presence/fingerprint',
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppTheme.primaryTheme_2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                  child: Text(
                                    'Sidik Jari',
                                    style: AppTextStyle.poppinsTextStyle(
                                      color: AppTheme.white,
                                      fontSize: 14,
                                      fontsWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/schedule/presence/camera',
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppTheme.primaryTheme_2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                  child: Text(
                                    ' Foto Kamera',
                                    style: AppTextStyle.poppinsTextStyle(
                                      color: AppTheme.white,
                                      fontSize: 14,
                                      fontsWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Text(
                    "Hadir",
                    style: AppTextStyle.poppinsTextStyle(
                      fontsWeight: FontWeight.w500,
                      fontSize: 14,
                      color: AppTheme.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
