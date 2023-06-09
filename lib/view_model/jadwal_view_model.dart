import 'package:flutter/material.dart';
import 'package:presencee/model/API/jadwal_api.dart';
import 'package:presencee/view_model/mahasiswa_view_model.dart';
import '../model/jadwal_model.dart';

enum DataStatus {
  initial,
  loading,
  completed,
  error,
}

class JadwalViewModel extends ChangeNotifier {
  List<Data> _jadwals = [];
  List<Data> _filterJadwals = [];
  DataStatus _status = DataStatus.initial;

  List<Data> get jadwals => _jadwals;
  List<Data> get filterJadwals => _filterJadwals;

  DataStatus get status => _status;

  getJadwal({required int pages, required int limits}) async {
    _status = DataStatus.loading;
    notifyListeners();

    try {
      final allJadwal =
          await JadwalApi.getPageJadwal(pages: pages, limits: limits);
      _jadwals = allJadwal;
      _status = DataStatus.completed;
    } catch (e) {
      _status = DataStatus.error;
    }
    notifyListeners();
  }

  getFilterJadwal(
      {required int userId,
      required String jamAfter,
      required String jamBefore}) async {
    _status = DataStatus.loading;
    notifyListeners();

    try {
      final filterJadwal = await JadwalApi.getFilterJadwal(
          userId: userId, jamAfter: jamAfter, jamBefore: jamBefore);
      _filterJadwals = filterJadwal;
      _status = DataStatus.completed;
    } catch (e) {
      _status = DataStatus.error;
    }
    notifyListeners();
  }

  getFilterJadwalSemua(
      {required int userId,
      required String jamAfter,
      required String jamBefore}) async {
    _status = DataStatus.loading;
    notifyListeners();

    try {
      final filterJadwalSemua = await JadwalApi.getFilterJadwal(
          userId: userId, jamAfter: jamAfter, jamBefore: jamBefore);
      _jadwals = filterJadwalSemua;
      _status = DataStatus.completed;
    } catch (e) {
      _status = DataStatus.error;
    }
    notifyListeners();
  }
}
