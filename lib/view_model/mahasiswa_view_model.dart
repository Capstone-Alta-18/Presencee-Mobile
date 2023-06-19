import 'package:flutter/material.dart';
import 'package:presencee/model/API/dosen_api.dart';
import 'package:presencee/model/dosen_model.dart';
import '../model/API/mahasiswa_api.dart';
import '../model/mahasiswa_model.dart';

enum Status {
  initial,
  loading,
  completed,
  error,
}

class MahasiswaViewModel extends ChangeNotifier {
  List<Mahasiswas> _siswas = [];
  Mahasiswas _siswaOne = Mahasiswas();
  List<Mahasiswas> get mahasiswass => _siswas;
  Mahasiswas get mahasiswaSingle => _siswaOne;

  Status _state = Status.initial;
  Status get state => _state;

  getMahasiswa() async {
    _state = Status.loading;
    notifyListeners();
    try {
      final mahasiswass = await MahasiswaAPI.getMahasiswa();
      _siswas = mahasiswass;
      _state = Status.completed;
    } catch (e) {
      _state = Status.error;
    }
    notifyListeners();
  }

  getOneMahasiswa({required int oneId}) async {
    _state = Status.loading;
    try {
      final mahasiswaSingle = await MahasiswaAPI.getOneMahasiswa(oneId: oneId);
      _siswaOne = mahasiswaSingle;
      _state = Status.completed;
      notifyListeners();
    } catch (e) {
      _state = Status.error;
      notifyListeners();
    }
    notifyListeners();
  }
}



