import 'package:flutter/material.dart';
import 'package:presencee/model/API/absensi_api.dart';
import 'package:presencee/model/filter_absensi_model.dart';
import 'package:presencee/view_model/user_view_model.dart';
import '../model/absensi_model.dart';

// enum DataState {
//   initial,
//   loading,
//   loaded,
//   error,
// }

class AbsensiViewModel extends ChangeNotifier {
  final AbsensiAPI absensiAPI = AbsensiAPI();
  String? image;
  Absensi? _absensi;
  List<FilterAbsen> _listAbsensi = [];
  DataState _state = DataState.initial;
  Absensi? get absensi => _absensi;
  List<FilterAbsen> get listAbsensi => _listAbsensi;
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

  Future<List<FilterAbsen>> getAbsen({
    required int userId,
    required int mahasiswaId,
    required int jadwalId,
    required String createdAfter,
    required String createdBefore,
  }) async {
    _state = DataState.loading;
    notifyListeners();
    try {
      final listabsensi = await absensiAPI.getAbsen(
          userId, mahasiswaId, jadwalId, createdAfter, createdBefore);
      _listAbsensi = listabsensi;
      _state = DataState.loaded;
      // notifyListeners();
    } catch (e) {
      _state = DataState.error;
      // notifyListeners();
      // rethrow;
    }
    notifyListeners();
    return _listAbsensi;

    
  }
}
