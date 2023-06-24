import 'package:flutter/material.dart';
import 'package:presencee/model/API/riwayat_kehadiran_api.dart';
import 'package:presencee/model/riwayat_kehadiran_model.dart';

enum DataState {
  initial,
  loading,
  loaded,
  error,
}

class KehadiranViewModel extends ChangeNotifier {
  List<RiwayatKehadiran> _kehadiran = [];
  DataState _state = DataState.initial;
  RiwayatKehadiran _kehadiranNew = RiwayatKehadiran();

  List<RiwayatKehadiran> get kehadiran => _kehadiran;
  RiwayatKehadiran get kehadiranNew => _kehadiranNew;

  DataState get state => _state;

  getKehadiran() async {
    _state = DataState.loading;
    notifyListeners();
    try {
      final kehadiran = await KehadiranApi.getKehadiran();
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
