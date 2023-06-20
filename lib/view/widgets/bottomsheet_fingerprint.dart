import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:local_auth/local_auth.dart';
import 'package:presencee/view/widgets/alerted_success_attendance.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
// import 'package:presencee/view/auth/local_auth_biometrics.dart';
import 'package:presencee/theme/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:presencee/view_model/absensi_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class FingerprintBottomsheet extends StatefulWidget {
  const FingerprintBottomsheet({super.key});

  @override
  State<FingerprintBottomsheet> createState() => _FingerprintBottomsheetState();
}

class _FingerprintBottomsheetState extends State<FingerprintBottomsheet> {
  static final auth = LocalAuthentication();
  String? location;
  String? address;
  bool isLoading = false;

  @override
  void initState() {
    // AuthBiometrics.authenticate();
    _getLocation();
    super.initState();
  }

  static Future<bool> hasBiometrics(BuildContext context) async {
    final isDeviceSupport = await auth.isDeviceSupported();
    try {
      bool canCheckBiometrics = await auth.canCheckBiometrics;
      if (!canCheckBiometrics) {
        SnackbarAlertDialog().customDialogs(context,
            message: "Presensi Gagal",
            icons: PhosphorIcons.x_circle_fill,
            iconColor: AppTheme.error,
            backgroundsColor: AppTheme.white,
            durations: 1200);
      }
      return canCheckBiometrics;
    } on PlatformException catch (e) {
      SnackbarAlertDialog().customDialogs(context,
          message: "Presensi Gagal, tidak ada sidik jari",
          icons: PhosphorIcons.x_circle_fill,
          iconColor: AppTheme.error,
          backgroundsColor: AppTheme.white,
          durations: 1200);
      return false;
    }
  }

  Future<void> authenticate() async {
    bool isAuthenticated = false;
    bool canCheckBiometrics = await hasBiometrics(context);

    if (canCheckBiometrics) {
      _getLocation();
      isAuthenticated = await auth.authenticate(
        localizedReason: 'Untuk absen silahkan masukan sidik jari anda',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );

      if (isAuthenticated) {
        setState(() {
          isLoading = true;
        });
        var timezone = await convertTimeZone();
        var now = DateTime.now().toString().split(' ');
        var tm = timezone.toString().split(':');
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
                  location: location!,
                  image: '');
          if (mounted) {
            SnackbarAlertDialog().customDialogs(context,
                message: "Presensi Berhasil",
                icons: PhosphorIcons.check_circle,
                iconColor: AppTheme.success,
                backgroundsColor: AppTheme.white,
                durations: 900);
            await Future.delayed(const Duration(milliseconds: 350));
            if (mounted) {
              Navigator.pop(context);
              Navigator.pop(context);
            }
          }
        }
      } else {
        if (mounted) {
          SnackbarAlertDialog().customDialogs(context,
              message: "Presensi Gagal, tidak ada sidik jari",
              icons: PhosphorIcons.x_circle_fill,
              iconColor: AppTheme.error,
              backgroundsColor: AppTheme.white,
              durations: 1200);
        }
      }
    } else {
      if (mounted) {
        SnackbarAlertDialog().customDialogs(context,
            message: "Presensi Gagal, kelas telah selesai",
            icons: PhosphorIcons.x_circle_fill,
            iconColor: AppTheme.error,
            backgroundsColor: AppTheme.white,
            durations: 1200);
      }
    }
  }

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

  Future<void> openAppSettings() {
    // return AppSettings.openAppSettings();
    return Geolocator.openLocationSettings();
  }

  Future<void> _getLocation() async {
    bool serviceEnabled;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      debugPrint('Location services are disabled.');
      if (mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Aktifkan Lokasi'),
            content: const Text(
                'Aplikasi membutuhkan akses lokasi GPS. Aktifkan lokasi sekarang?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Batal'),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  setState(() {
                    _requestLocationPermission();
                  });
                },
                child: const Text('Aktifkan'),
              ),
            ],
          ),
        );
      }
      return;
    }
  }

  Future<void> _requestLocationPermission() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      debugPrint(
          'Location permissions are permanently denied, we cannot request permissions.');
      if (mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Izin Ditolak'),
            content: const Text(
                'Aplikasi tidak dapat mengakses lokasi karena izin akses lokasi ditolak secara permanen.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
      return;
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        debugPrint(
            'Location permissions are denied (actual value: $permission).');
        if (mounted) {
          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Izin Ditolak'),
              content: const Text(
                  'Aplikasi tidak dapat mengakses lokasi karena izin akses lokasi ditolak.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      // if (placemarks != null && placemarks.isNotEmpty) {
      Placemark placemark = placemarks[0];
      String address =
          "${placemark.subLocality}, ${placemark.locality}, ${placemark.country}";
      // "${placemark.street},
      print(placemark);
      print(address);
      setState(() {
        location = address;
        print(location);
      });
      // }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 1.5,
        decoration: const BoxDecoration(
          color: AppTheme.gray,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
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
            SizedBox(height: MediaQuery.of(context).size.height / 6),
            Text(
              'Letakkan sidik jari',
              style: AppTextStyle.poppinsTextStyle(
                color: AppTheme.black_3,
                fontsWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: 70,
              height: 90,
              child: OutlinedButton(
                onLongPress: () => authenticate(),
                onPressed: () => authenticate(),
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.all(0)),
                  side: MaterialStateProperty.all<BorderSide>(
                      const BorderSide(color: AppTheme.gray_2, width: 3)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                child: const Icon(
                  PhosphorIcons.fingerprint,
                  size: 60,
                  color: AppTheme.gray_2,
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
