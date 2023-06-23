import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:local_auth/local_auth.dart';
import 'package:presencee/model/mahasiswa_model.dart';
import 'package:presencee/view/widgets/alerted_attendance.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:presencee/theme/constant.dart';
import 'package:flutter/material.dart';
import 'package:presencee/view_model/absensi_view_model.dart';
import 'package:presencee/view_model/app_view_model.dart';
import 'package:presencee/view_model/mahasiswa_view_model.dart';
import 'package:provider/provider.dart';

class FingerprintBottomsheet extends StatefulWidget {
  const FingerprintBottomsheet({
    super.key,
  });

  @override
  State<FingerprintBottomsheet> createState() => _FingerprintBottomsheetState();
}

class _FingerprintBottomsheetState extends State<FingerprintBottomsheet> {
  static final auth = LocalAuthentication();
  String? location;
  String? address;
  bool isLoading = false;
  Map absenData = {};
  Mahasiswas mahasiswa = Mahasiswas();

  @override
  void initState() {
    getData();
    _getLocation();
    super.initState();
  }

  void getData() {
    mahasiswa =
        Provider.of<MahasiswaViewModel>(context, listen: false).mahasiswaSingle;
    absenData = Provider.of<AppViewModel>(context, listen: false).dataAbsen;
    setState(() {});
  }

  static Future<bool> hasBiometrics(BuildContext context) async {
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
        var now = DateTime.now().toString().split(' ');
        if (mounted) {
          await Provider.of<AbsensiViewModel>(context, listen: false)
              .createAbsen(
                  userId: mahasiswa.userId!,
                  mahasiswaId: mahasiswa.id!,
                  jadwalId: absenData['idJadwal'],
                  timeAttemp: "${now[0]}T${now[1].split('.')[0]}+00:00",
                  matakuliah: absenData['namaMatkul'],
                  status: 'Hadir',
                  location: location!,
                  image: '');
          if (mounted) {
            var nows = DateTime.now();
            var previousMonday =
                nows.subtract(Duration(days: nows.weekday - 1));
            var nextSaturday = previousMonday.add(const Duration(days: 6));
            var createdAfter =
                DateFormat('yyyy-MM-ddT00:00:00+00:00').format(previousMonday);
            var createdBefore =
                DateFormat('yyyy-MM-ddT23:59:00+00:00').format(nextSaturday);

            await Provider.of<AbsensiViewModel>(context, listen: false)
                .getAbsen(
                    userId: mahasiswa.userId!,
                    mahasiswaId: mahasiswa.id!,
                    jadwalId: absenData['idJadwal'],
                    createdAfter: createdAfter,
                    createdBefore: createdBefore);
            await Future.delayed(const Duration(milliseconds: 350));
            if (mounted) {
              SnackbarAlertDialog().customDialogs(context,
                  message: "Presensi Berhasil",
                  icons: PhosphorIcons.check_circle,
                  iconColor: AppTheme.success,
                  backgroundsColor: AppTheme.white,
                  durations: 900);
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

  Future<void> openAppSettings() {
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
    } else {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );
        Placemark placemark = placemarks[0];
        String address =
            "${placemark.subLocality}, ${placemark.locality}, ${placemark.country}";
        setState(() {
          location = address;
        });
      } catch (e) {
        debugPrint('Error: $e');
      }
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
      Placemark placemark = placemarks[0];
      String address =
          "${placemark.subLocality}, ${placemark.locality}, ${placemark.country}";
      setState(() {
        location = address;
      });
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
