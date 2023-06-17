import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:intl/intl.dart';
import 'package:presencee/theme/constant.dart';
import 'package:presencee/view_model/absensi_view_model.dart';
import 'package:presencee/view_model/upload_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreviewScreen extends StatefulWidget {
  final XFile imgPath;
  final String location;
  const PreviewScreen(
      {super.key, required this.imgPath, required this.location});

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  void uploadImage() async {
    await Provider.of<UploadImageViewModel>(context, listen: false)
        .uploadImage(widget.imgPath);
    if (mounted) {
      final url =
          Provider.of<UploadImageViewModel>(context, listen: false).image?.url;
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final idUser = sharedPreferences.getInt('id_user');
      final idMahasiswa = sharedPreferences.getInt('id_mahasiswa');
      // var f = DateFormat("yyyy-MM-ddTHH:mm:ss").format(DateTime.now());
      // print(f);
      if (mounted) {
        await Provider.of<AbsensiViewModel>(context, listen: false).createAbsen(
            userId: idUser!,
            mahasiswaId: idMahasiswa!,
            jadwalId: 1,
            timeAttemp: '2023-06-18T03:40:50+08:00',
            // DateFormat("yyyy-MM-dd'T'HH:mm:ssZ").format(DateTime.now()),
            matakuliah: 'Akuntansi',
            status: 'Hadir',
            location: widget.location,
            image: url!);
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
                  const SizedBox(height: 81),
                  ElevatedButton(
                    onPressed: () {
                      uploadImage();
                    }
                    // Navigator.pushNamed(
                    //     context, '/schedule/presence/fingerprint')
                    ,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryTheme_2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    child: Text(
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
