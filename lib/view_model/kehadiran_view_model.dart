import 'package:flutter/material.dart';
import 'package:presencee/model/API/riwayat_kehadiran.dart';
import 'package:presencee/model/riwayat_dashboard.dart';
import 'package:presencee/model/riwayat_kehadiran_model.dart';
import 'package:presencee/view_model/user_view_model.dart';

// enum DataState {
//   initial,
//   loading,
//   loaded,
//   error,
// }

class KehadiranViewModel extends ChangeNotifier {
  KehadiranApi kehadiranApi = KehadiranApi();
  RiwayatDashboard _kehadiran = RiwayatDashboard(); 
  RiwayatKehadiran _kehadiranNew = RiwayatKehadiran();
  DataState _state = DataState.initial;

  RiwayatDashboard get kehadiran => _kehadiran;
  RiwayatKehadiran get kehadiranNew => _kehadiranNew;

  DataState get state => _state;

  getKehadiran({required int idMhs, required String afterTime, required String beforeTime, required int jadwalId}) async {
    _state = DataState.loading;
    notifyListeners();
    try {
      final kehadiran = await KehadiranApi.getKehadiran(idMhs: idMhs, afterTime: afterTime, beforeTime: beforeTime, jadwalId: jadwalId);
      _kehadiran = kehadiran;
      _state = DataState.loaded;
    } catch (e) {
      _state = DataState.error;
    }
    notifyListeners();
  }
  getKehadiranNew({required int idMhs, required String afterTime, required String beforeTime}) async {
    _state = DataState.loading;
    notifyListeners();
    try {
      final kehadiranNew = await KehadiranApi.getKehadiranNew(idMhs: idMhs,afterTime: afterTime,beforeTime: beforeTime);
      _kehadiranNew = kehadiranNew;
      _state = DataState.loaded;
    } catch (e) {
      _state = DataState.error;
    }
    notifyListeners();
  }
}
