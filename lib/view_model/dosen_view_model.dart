import 'package:flutter/material.dart';
import 'package:presencee/model/API/dosen_api.dart';
import 'package:presencee/model/dosen_model.dart';
import 'package:presencee/view_model/kehadiran_view_model.dart';
import 'package:presencee/view_model/user_view_model.dart';


class DosenViewModel extends ChangeNotifier {
  DosenModel _dosenModel = DosenModel();
  DataState _state = DataState.initial;
  DosenModel get dosen => _dosenModel;

  DataState get state => _state;

  getDosenModel() async {
    _state = DataState.loading;
    notifyListeners();
    try {
      final dosen = await DosenApi.getDosenApi();
      _dosenModel = dosen;
      _state = DataState.loaded;
    } catch (e) {
      _state = DataState.error;
    }
    notifyListeners();
  }
}