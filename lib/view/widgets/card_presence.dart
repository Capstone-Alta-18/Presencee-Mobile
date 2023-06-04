import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:presencee/theme/constant.dart';

class CardPresence extends StatefulWidget {
  const CardPresence({super.key});

  @override
  State<CardPresence> createState() => _CardPresenceState();
}

class _CardPresenceState extends State<CardPresence> {
  int? _selectedValue;

  File? _image;
  String? _location;

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
        _getLocation();
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are disabled.');
      return;
    }

    // Request location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      print(
          'Location permissions are permanently denied, we cannot request permissions.');
      return;
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        print('Location permissions are denied (actual value: $permission).');
        return;
      }
    }

    // Get the current location
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _location = 'Lat: ${position.latitude}, Long: ${position.longitude}';
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
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              '200280120739',
              style: AppTextStyle.poppinsTextStyle(
                color: AppTheme.black_3,
                fontsWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: AppTheme.primaryTheme_5,
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
                              title: Center(
                                  child: Text(
                                'Alasan Absen',
                                style: AppTextStyle.poppinsTextStyle(
                                  color: AppTheme.black,
                                  fontSize: 24,
                                  fontsWeight: FontWeight.w600,
                                ),
                              )),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    title: const Text('Sakit'),
                                    titleTextStyle:
                                        AppTextStyle.poppinsTextStyle(
                                            fontsWeight: FontWeight.w400,
                                            fontSize: 14,
                                            color: AppTheme.black),
                                    leading: Radio<int>(
                                        value: 1,
                                        groupValue: _selectedValue,
                                        onChanged: (int? value) {
                                          setState(() {
                                            _selectedValue = value;
                                          });
                                        }),
                                  ),
                                  ListTile(
                                    title: const Text('Izin'),
                                    titleTextStyle:
                                        AppTextStyle.poppinsTextStyle(
                                            fontsWeight: FontWeight.w400,
                                            fontSize: 14,
                                            color: AppTheme.black),
                                    leading: Radio<int>(
                                        value: 2,
                                        groupValue: _selectedValue,
                                        onChanged: (int? value) {
                                          setState(() {
                                            _selectedValue = value;
                                          });
                                        }),
                                  ),
                                  ListTile(
                                    title: const Text('Sakit'),
                                    titleTextStyle:
                                        AppTextStyle.poppinsTextStyle(
                                            fontsWeight: FontWeight.w400,
                                            fontSize: 14,
                                            color: AppTheme.black),
                                    leading: Radio<int>(
                                        value: 3,
                                        groupValue: _selectedValue,
                                        onChanged: (int? value) {
                                          setState(() {
                                            _selectedValue = value;
                                          });
                                        }),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: AppTheme.white,
                                          side: const BorderSide(
                                            color: AppTheme.primaryTheme_2,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                          ),
                                        ),
                                        onPressed: () {},
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
                                          primary: AppTheme.primaryTheme_2,
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
                                  )
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
                    primary: AppTheme.primaryTheme_2,
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
                          title: Center(
                              child: Text(
                            'Pilih metode Presensi',
                            style: AppTextStyle.poppinsTextStyle(
                              color: AppTheme.black,
                              fontSize: 24,
                              fontsWeight: FontWeight.w600,
                            ),
                          )),
                          content: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, '/fingerprint');
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: AppTheme.primaryTheme_2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                  child: Text(
                                    ' Sidik Jari',
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
                                    _getImage();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: AppTheme.primaryTheme_2,
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
