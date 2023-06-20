import 'package:flutter/material.dart';
import 'package:presencee/model/API/jadwal_api.dart';
import '../model/jadwal_model.dart';

enum DataStatus {
  initial,
  loading,
  completed,
  error,
}

class JadwalViewModel extends ChangeNotifier {
  List<JadwalPelajaran> _jadwals = [];
  List<JadwalPelajaran> filteredJadwals = [];
  DataStatus _status = DataStatus.initial;

  List<JadwalPelajaran> get jadwals => _jadwals;

  DataStatus get status => _status;

  getJadwal({required int pages, required int limits}) async {
    _status = DataStatus.loading;
    notifyListeners();

    try {
      final allJadwal = await JadwalApi.getPageJadwal(pages: pages, limits: limits);
      _jadwals = allJadwal;
      _status = DataStatus.completed;
    } catch (e) {
      _status = DataStatus.error;
    }
    notifyListeners();
  }

  searchJadwal(String query) {
    filteredJadwals = jadwals.where((jadwal) => jadwal.name!.toLowerCase().contains(query.toLowerCase())).toList();
    notifyListeners();
  }

  searchJadwalByDosen(String query) {
    filteredJadwals = jadwals.where((jadwal) => jadwal.dosen!.name!.toLowerCase().contains(query.toLowerCase())).toList();
    notifyListeners();
  }

}