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
  List<Mahasiswas> _siswas = [];
  DataState _state = DataState.initial;

  List<Mahasiswas> get mahasiswass => _siswas;

  DataState get state => _state;

  getMahasiswa() async {
    _state = DataState.loading;
    notifyListeners();
    try {
      final mahasiswass = await MahasiswaAll.getMahasiswa();
      _siswas = mahasiswass;
      _state = DataState.loaded;
    } catch (e) {
      _state = DataState.error;
    }
    notifyListeners();
  }
}

class MahasiswaOneViewModel extends ChangeNotifier {
  List<Mahasiswas> _siswas = [];
  DataState _state = DataState.initial;

  List<Mahasiswas> get pelajar => _siswas;

  DataState get state => _state;

  getOneMahasiswa({required int ids}) async {
    _state = DataState.loading;
    notifyListeners();
    try {
      final pelajar = await MahasiswaOne.getOneMahasiswa(ids: ids);
      _siswas = pelajar;
      _state = DataState.loaded;
    } catch (e) {
      _state = DataState.error;
    }
    notifyListeners();
  }
  
}