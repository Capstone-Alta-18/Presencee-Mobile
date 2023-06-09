import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:presencee/model/mahasiswa_model.dart';
import 'package:presencee/theme/constant.dart';
import 'package:presencee/view/pages/preview_camera_view.dart';

class CameraView extends StatefulWidget {
  const CameraView({
    super.key,
  });

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  CameraController? cameraController;
  List<dynamic> cameras = [];
  int selectedCameraIndex = 0;
  String? location;
  String? address;
  XFile? imageFile;
  String? imageString;
  Map absenData = {};
  Mahasiswas mahasiswa = Mahasiswas();

  @override
  void initState() {
    _getLocation();
    availableCameras().then((value) {
      cameras = value;
      if (cameras.length > 0) {
        selectedCameraIndex = 0;
        initCamera(cameras[selectedCameraIndex]).then((_) => {});
      } else {
        log('Tidak ada kamera');
      }
    }).catchError((e) {
      log(e.hashCode.toString());
    });
    super.initState();
  }

  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
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

  Future initCamera(CameraDescription cameraDescription) async {
    if (cameraController != null) {
      await cameraController?.dispose();
    }
    cameraController =
        CameraController(cameraDescription, ResolutionPreset.high);
    cameraController?.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    if (cameraController!.value.hasError) {}
    try {
      await cameraController?.initialize();
    } catch (e) {
      log('Kamera error $e');
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.black,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: cameraPreview(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 34),
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            PhosphorIcons.x,
                            color: AppTheme.white,
                          )),
                    ],
                  ),
                  Container(
                    height: 42,
                    width: MediaQuery.of(context).size.width,
                    color: AppTheme.black_2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Icon(
                          PhosphorIcons.map_pin_line,
                          color: AppTheme.white,
                        ),
                        Text(
                          location == null ? 'Loading' : location.toString(),
                          style: AppTextStyle.poppinsTextStyle(
                              color: AppTheme.white,
                              fontSize: 16,
                              fontsWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 120,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const Spacer(),
                  cameraControl(context),
                  cameraToogle(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget cameraPreview() {
    if (cameraController == null || !cameraController!.value.isInitialized) {
      return Text(
        'loading',
        style: AppTextStyle.poppinsTextStyle(color: AppTheme.white),
      );
    }
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width,
      child: CameraPreview(cameraController!),
    );
  }

  Widget cameraToogle() {
    if (cameras == null || cameras.isEmpty) {
      return const Spacer();
    }
    CameraDescription selectedCamera = cameras[selectedCameraIndex];
    CameraLensDirection lensDirection = selectedCamera.lensDirection;
    return Expanded(
        child: Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
                onPressed: () {
                  onSwitchCamera();
                },
                icon: Icon(
                  getCameraIcon(lensDirection),
                  color: AppTheme.black_2,
                  size: 35,
                ))));
  }

  getCameraIcon(lensDirection) {
    switch (lensDirection) {
      case CameraLensDirection.back:
        return Icons.change_circle_rounded;
      case CameraLensDirection.front:
        return Icons.change_circle_rounded;
      case CameraLensDirection.external:
        return CupertinoIcons.photo_camera;
      default:
        return Icons.device_unknown;
    }
  }

  onSwitchCamera() {
    selectedCameraIndex =
        selectedCameraIndex < cameras.length - 1 ? selectedCameraIndex + 1 : 0;
    CameraDescription selectedCamera = cameras[selectedCameraIndex];
    initCamera(selectedCamera);
  }

  Widget cameraControl(context) {
    return Expanded(
        child: Align(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          FloatingActionButton(
            onPressed: () {
              onCapture(context);
            },
            backgroundColor: AppTheme.white,
            child: const Icon(
              Icons.circle_outlined,
              color: AppTheme.black,
              size: 55,
            ),
          )
        ],
      ),
    ));
  }

  onCapture(context) async {
    try {
      await cameraController!.takePicture().then((value) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => PreviewScreen(
                  imgPath: value,
                  location: location.toString(),
                )));
      });
    } catch (e) {
      log('$e');
    }
  }
}
