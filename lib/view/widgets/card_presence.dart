import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:presencee/theme/constant.dart';
import 'package:presencee/view/pages/camera_view.dart';
import 'package:presencee/view/widgets/alerted_success_attendance.dart';
import 'package:presencee/view_model/absensi_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class CardPresence extends StatefulWidget {
  const CardPresence({super.key});

  @override
  State<CardPresence> createState() => _CardPresenceState();
}

class _CardPresenceState extends State<CardPresence> {
  int? _selectedValue;
  String? location;
  String? address;

  Future<String> getTimeZone() async {
    String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    return timeZoneName;
  }

  Future<String> convertTimeZone() async {
    tz.initializeTimeZones();
    String timeZoneName = await getTimeZone();
    tz.Location location = tz.getLocation(timeZoneName);
    tz.TZDateTime now = tz.TZDateTime.now(location);
    String offset = now.timeZoneOffset.toString().split('.').first;
    return offset;
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
    var timezone = await convertTimeZone();
    var now = DateTime.now().toString().split(' ');
    var tm = timezone.toString().split(':');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final idUser = sharedPreferences.getInt('id_user');
    final idMahasiswa = sharedPreferences.getInt('id_mahasiswa');
    if (mounted) {
      await Provider.of<AbsensiViewModel>(context, listen: false).createAbsen(
          userId: idUser!,
          mahasiswaId: idMahasiswa!,
          jadwalId: 1,
          // timeAttemp: '2023-06-18T03:40:50+08:00',
          timeAttemp: "${now[0]}T${now[1].split('.')[0]}+0${tm[0]}:${tm[1]}",
          matakuliah: 'Akuntansi',
          status: status,
          location: '',
          image: '');
      if (mounted) {
        Navigator.pop(context);
        if (Provider.of<AbsensiViewModel>(context, listen: false)
                .absensi
                ?.message ==
            'success creating absen') {
          SnackbarAlertDialog().customDialogs(context,
              message: "Absensi berhasil",
              icons: PhosphorIcons.check_circle_fill,
              iconColor: AppTheme.success,
              backgroundsColor: AppTheme.white,
              durations: 1800);
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
              'Bahasa Indonesia',
              style: AppTextStyle.poppinsTextStyle(
                color: AppTheme.black,
                fontsWeight: FontWeight.w600,
                fontSize: 24,
              ),
            ),
            Text(
              '(MU)',
              style: AppTextStyle.poppinsTextStyle(
                color: AppTheme.black,
                fontsWeight: FontWeight.w600,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Abdul Jalil',
              style: AppTextStyle.poppinsTextStyle(
                color: AppTheme.black_2,
                fontsWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Senin 07.00 - 09.00',
              style: AppTextStyle.poppinsTextStyle(
                color: AppTheme.black_2,
                fontsWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Kristina Fabulous',
              style: AppTextStyle.poppinsTextStyle(
                color: AppTheme.black,
                fontsWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              '200280120739',
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
                                  onPressed: () => Navigator.pushNamed(context,
                                      '/schedule/presence/fingerprint'),
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
                                  // onPressed: () => _getImage(),
                                  onPressed: () {
                                    // _getLocation();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                CameraView()));
                                    // _getImage();
                                    // _getLocation();
                                    // Stack(children: [
                                    //   Positioned(
                                    //     top: 0,
                                    //     child: Text(
                                    //       location ?? 'Location not available',
                                    //       style: TextStyle(color: Colors.white),
                                    //     ),
                                    //   ),
                                    // ]);
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
