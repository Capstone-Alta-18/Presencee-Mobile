import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:presencee/model/mahasiswa_model.dart';
import 'package:presencee/view_model/absensi_view_model.dart';
import 'package:presencee/view_model/upload_view_model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:presencee/theme/constant.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:presencee/view_model/app_view_model.dart';
import 'package:presencee/view_model/mahasiswa_view_model.dart';

import '../widgets/alerted_attendance.dart';

class PreviewScreen extends StatefulWidget {
  final XFile imgPath;
  final String location;
  const PreviewScreen({
    super.key,
    required this.imgPath,
    required this.location,
  });

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  bool isLoading = false;
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

  void uploadImage() async {
    setState(() {
      isLoading = true;
    });
    var now = DateTime.now().toString().split(' ');
    if (mounted) {
      await Provider.of<UploadImageViewModel>(context, listen: false)
          .uploadImage(widget.imgPath);
      if (mounted) {
        final url = Provider.of<UploadImageViewModel>(context, listen: false)
            .image
            ?.url;
        if (mounted) {
          await Provider.of<AbsensiViewModel>(context, listen: false)
              .createAbsen(
                  userId: mahasiswa.userId!,
                  mahasiswaId: mahasiswa.id!,
                  jadwalId: absenData['idJadwal'],
                  timeAttemp: "${now[0]}T${now[1].split('.')[0]}+00:00",
                  matakuliah: absenData['namaMatkul'],
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
              var nows = DateTime.now();
              var previousMonday =
                  nows.subtract(Duration(days: nows.weekday - 1));
              var nextSaturday = previousMonday.add(const Duration(days: 6));
              var createdAfter = DateFormat('yyyy-MM-ddT00:00:00+00:00')
                  .format(previousMonday);
              var createdBefore =
                  DateFormat('yyyy-MM-ddT23:59:00+00:00').format(nextSaturday);

              await Provider.of<AbsensiViewModel>(context, listen: false)
                  .getAbsen(
                      userId: mahasiswa.userId!,
                      mahasiswaId: mahasiswa.id!,
                      jadwalId: absenData['idJadwal'],
                      createdAfter: createdAfter,
                      createdBefore: createdBefore);
              if (mounted) {
                SnackbarAlertDialog().customDialogs(context,
                    message: "Presensi berhasil",
                    icons: PhosphorIcons.check_circle_fill,
                    iconColor: AppTheme.success,
                    backgroundsColor: AppTheme.white,
                    durations: 1800);
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
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
                    mahasiswa.name!,
                    style: AppTextStyle.poppinsTextStyle(
                      color: AppTheme.black,
                      fontsWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    mahasiswa.nim!,
                    style: AppTextStyle.poppinsTextStyle(
                      color: AppTheme.black_3,
                      fontsWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  ElevatedButton(
                    onPressed: !isLoading ? () => uploadImage() : null,
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
