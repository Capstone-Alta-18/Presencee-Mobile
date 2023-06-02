import 'package:flutter/material.dart';
import '../../model/API/mahasiswa_api.dart';
import '../../model/mahasiswa_model.dart';

enum DataState {
  initial,
  loading,
  loaded,
  error,
}

class MahasiswaViewModel extends ChangeNotifier {
  List<MahasiswaModel> _mahasiswas = [];
  DataState _state = DataState.initial;

  List<MahasiswaModel> get mahasiswas => _mahasiswas;

  DataState get state => _state;

  getMahasiswa() async {
    _state = DataState.loading;
    notifyListeners();
    try {
      final mahasiswas = await MahasiswaApi.getMahasiswa();
      _mahasiswas = mahasiswas;
      _state = DataState.loaded;
    } catch (e) {
      _state = DataState.error;
    }
    notifyListeners();
  }
}