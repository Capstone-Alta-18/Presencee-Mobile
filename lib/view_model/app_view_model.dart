import 'package:flutter/material.dart';

class AppViewModel extends ChangeNotifier {
  Map _dataAbsen = {};
  Map get dataAbsen => _dataAbsen;

  Future<Map> absenData(Map data) async {
    notifyListeners();
    try {
      _dataAbsen = data;

      notifyListeners();
      return _dataAbsen;
    } catch (e) {
      notifyListeners();
      return {
        'message': e.toString(),
      };
    }
  }
}
