import 'package:flutter/material.dart';
import 'package:presencee/model/API/jadwal_api.dart';
import '../model/jadwal_model.dart';

enum Status {
  initial,
  loading,
  completed,
  error,
}

class JadwalViewModel extends ChangeNotifier {
  List<Data> _jadwals = [];
  Status _status = Status.initial;

  List<Data> get jadwals => _jadwals;

  Status get status => _status;

  getJadwal({required int pages, required int limits}) async {
    _status = Status.loading;
    notifyListeners();

    try {
      final allJadwal = await JadwalApi.getPageJadwal(pages: pages, limits: limits);
      _jadwals = allJadwal;
      _status = Status.completed;
    } catch (e) {
      _status = Status.error;
    }
    notifyListeners();
  }
}