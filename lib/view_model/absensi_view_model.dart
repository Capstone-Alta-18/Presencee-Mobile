import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:presencee/model/API/absensi_api.dart';

import '../model/absensi_model.dart';

enum DataState {
  initial,
  loading,
  loaded,
  error,
}

class AbsensiViewModel extends ChangeNotifier {
  final AbsensiAPI absensiAPI = AbsensiAPI();
  String? image;
  Absensi? _absensi;
  DataState _state = DataState.initial;
  Absensi? get absensi => _absensi;
  DataState get state => _state;

  Future<void> createAbsen(
    int user_id,
    int mahasiswa_id,
    int jadwal_id,
    String time_attemp,
    String matakuliah,
    String status,
    String location,
    String image,
  ) async {
    _state = DataState.loading;
    notifyListeners();
    try {
      _absensi = await absensiAPI.createAbsen(user_id, mahasiswa_id, jadwal_id,
          time_attemp, matakuliah, status, location, image);

      _state = DataState.loaded;
      notifyListeners();
    } catch (e) {
      _state = DataState.error;
      notifyListeners();
    }
  }

  Future<void> uploadImage(XFile image) async {
    _state = DataState.loading;
    notifyListeners();
    try {
      _absensi = await absensiAPI.uploadImage(image);
      _state = DataState.loaded;
      notifyListeners();
    } catch (e) {
      _state = DataState.error;
      notifyListeners();
    }
  }
}
