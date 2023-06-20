import 'package:presencee/model/API/absensi_api.dart';
import 'package:flutter/material.dart';
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

  Future<void> createAbsen({
    required int userId,
    required int mahasiswaId,
    required int jadwalId,
    required String timeAttemp,
    required String matakuliah,
    required String status,
    required String location,
    required String image,
  }) async {
    _state = DataState.loading;
    notifyListeners();
    try {
      _absensi = await absensiAPI.createAbsen(userId, mahasiswaId, jadwalId,
          timeAttemp, matakuliah, status, location, image);

      _state = DataState.loaded;
      notifyListeners();
    } catch (e) {
      _state = DataState.error;
      notifyListeners();
    }
  }
}
