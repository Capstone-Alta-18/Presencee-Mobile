import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:presencee/view_model/absensi_view_model.dart';
import 'package:presencee/view_model/upload_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:presencee/theme/constant.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../widgets/alerted_attendance.dart';

class PreviewScreen extends StatefulWidget {
  final XFile imgPath;
  final String location;
  const PreviewScreen(
      {super.key, required this.imgPath, required this.location});

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  bool isLoading = false;
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

  void uploadImage() async {
    setState(() {
      isLoading = true;
    });
    var timezone = await convertTimeZone();
    var now = DateTime.now().toString().split(' ');
    var tm = timezone.toString().split(':');
    if (mounted) {
      await Provider.of<UploadImageViewModel>(context, listen: false)
          .uploadImage(widget.imgPath);
      if (mounted) {
        final url = Provider.of<UploadImageViewModel>(context, listen: false)
            .image
            ?.url;
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        final idUser = sharedPreferences.getInt('id_user');
        final idMahasiswa = sharedPreferences.getInt('id_mahasiswa');
        if (mounted) {
          await Provider.of<AbsensiViewModel>(context, listen: false)
              .createAbsen(
                  userId: idUser!,
                  mahasiswaId: idMahasiswa!,
                  jadwalId: 1,
                  // timeAttemp: '2023-06-18T03:40:50+08:00',
                  timeAttemp:
                      "${now[0]}T${now[1].split('.')[0]}+0${tm[0]}:${tm[1]}",
                  matakuliah: 'Akuntansi',
                  status: 'Hadir',
                  location: widget.location,
                  image: url!);
          if (mounted) {
            setState(() {
              isLoading = false;
            });
            if (Provider.of<AbsensiViewModel>(context, listen: false)
                    .absensi
                    ?.message ==
                'success creating absen') {
              SnackbarAlertDialog().customDialogs(context,
                  message: "Presensi berhasil",
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
                  message: "Presensi gagal, kelas telah selesai",
                  icons: PhosphorIcons.x_circle_fill,
                  iconColor: AppTheme.error,
                  backgroundsColor: AppTheme.white,
                  durations: 1800);
            }
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppTheme.gray_2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppTheme.gradient_3, AppTheme.gradient_2],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 40),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        // Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        PhosphorIcons.x,
                        color: AppTheme.white,
                        size: 28,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 287,
                        width: 342,
                        child: Image.file(
                          File(widget.imgPath.path),
                          fit: BoxFit.fill,
                        ),
                      ),
                      Container(
                        height: 66,
                        width: MediaQuery.of(context).size.width,
                        color: AppTheme.gray_6,
                        child: Row(
                          children: [
                            const SizedBox(width: 15),
                            const Icon(
                              PhosphorIcons.map_pin_line,
                              color: AppTheme.white,
                            ),
                            const SizedBox(width: 15),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.location,
                                  style: AppTextStyle.poppinsTextStyle(
                                      color: AppTheme.white,
                                      fontSize: 12,
                                      fontsWeight: FontWeight.w400),
                                ),
                                Text(
                                  DateFormat('EEEE, d MMMM yyyy', 'id')
                                      .format(DateTime.now()),
                                  style: AppTextStyle.poppinsTextStyle(
                                      color: AppTheme.white,
                                      fontSize: 12,
                                      fontsWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: AppTheme.gray,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(20))),
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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  ElevatedButton(
                    onPressed: !isLoading
                        ? () => uploadImage()
                        : null
                    // Navigator.pushNamed(
                    //     context, '/schedule/presence/fingerprint')
                    ,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryTheme_2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 128,
                            child: SpinKitThreeBounce(
                              color: AppTheme.white,
                              size: 13.3,
                            ),
                          )
                        : Text(
                            'Konfirmasi Kehadiran',
                            style: AppTextStyle.poppinsTextStyle(
                              color: AppTheme.white,
                              fontSize: 14,
                              fontsWeight: FontWeight.w400,
                            ),
                          ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
