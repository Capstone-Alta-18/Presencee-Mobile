import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:presencee/theme/constant.dart';
import 'package:presencee/view/pages/camera_view.dart';

class CardPresence extends StatefulWidget {
  const CardPresence({super.key});

  @override
  State<CardPresence> createState() => _CardPresenceState();
}

class _CardPresenceState extends State<CardPresence> {
  int? _selectedValue;
  File? image;
  String? location;

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedImage != null) {
        image = File(pickedImage.path);
        _getLocation();
      } else {
        debugPrint('No image selected.');
      }
    });
  }

  Future<void> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      debugPrint('Location services are disabled.');
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      debugPrint(
          'Location permissions are permanently denied, we cannot request permissions.');
      return;
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        debugPrint(
            'Location permissions are denied (actual value: $permission).');
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      location = 'Lat: ${position.latitude}, Long: ${position.longitude}';
    });
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
              'Senin',
              style: AppTextStyle.poppinsTextStyle(
                color: AppTheme.black_2,
                fontsWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              '07.00 - 09.00',
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
                                'Alasan Absen',
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                            color: AppTheme.black,
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
                                        onPressed: () {},
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
