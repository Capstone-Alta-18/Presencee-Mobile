import 'package:flutter/material.dart';
import 'package:presencee/model/API/user_api.dart';
import 'package:presencee/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum DataState {
  initial,
  loading,
  loaded,
  error,
}

class UserViewModel extends ChangeNotifier {
  final UserAPI _userAPI = UserAPI();
  User? _user;
  DataState _state = DataState.initial;
  User? get user => _user;

  DataState get state => _state;

  Future<void> userLogin(String email, String password) async {
    _state = DataState.loading;
    notifyListeners();
    try {
      _user = await _userAPI.userLogin(email, password);
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('token', user?.token ?? '');
      await sharedPreferences.setInt(
          'id_mahasiswa', user?.data?.mahasiswa?.id ?? 0);
      _state = DataState.loaded;
      // notifyListeners();
    } catch (e) {
      _state = DataState.error;
      notifyListeners();
    }
  }
}
