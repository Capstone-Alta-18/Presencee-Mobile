import 'package:flutter/material.dart';
import 'package:presencee/model/API/riwayat_kehadiran.dart';
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

  List<RiwayatKehadiran> get kehadiran => _kehadiran;

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
}