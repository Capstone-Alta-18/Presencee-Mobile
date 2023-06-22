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
  MahasiswaStatus _mahasiswaStatus = MahasiswaStatus();
  List<Mahasiswas> get mahasiswass => _siswas;
  Mahasiswas get mahasiswaSingle => _siswaOne;
  MahasiswaStatus get mahasiswaStatus => _mahasiswaStatus;

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

  updateMahasiswa(
      {required int idMahasiswa,
      required String name,
      required String email,
      required String nim,
      required String image,
      required String phone,
      required String jurusan,
      required String tahunMasuk,
      required String ipk,
      required int userId}) async {
    _state = Status.loading;
    try {
      final mahasiswaStatus = await MahasiswaAPI.updateMahasiswa(
          idMahasiswa: idMahasiswa,
          name: name,
          email: email,
          nim: nim,
          image: image,
          phone: phone,
          jurusan: jurusan,
          tahunMasuk: tahunMasuk,
          ipk: ipk,
          userId: userId);
      _mahasiswaStatus = mahasiswaStatus;
      _state = Status.completed;
      notifyListeners();
    } catch (e) {
      _state = Status.error;
      notifyListeners();
    }
    notifyListeners();
  }
}



