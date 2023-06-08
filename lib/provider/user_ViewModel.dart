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
  // List<UserModel> _mahasiswas = [];
  final UserAPI _userAPI = UserAPI();
  User? _user;
  DataState _state = DataState.initial;
  User? get user => _user;
  // List<UserModel> get mahasiswas => _mahasiswas;

  DataState get state => _state;

  /* getMahasiswa() async {
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
  } */
  Future<void> userLogin(String email, String password) async {
    _state = DataState.loading;
    notifyListeners();
    try {
      _user = await _userAPI.userLogin(email, password);
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('token', user?.token ?? '');
      // print("token : ${sharedPreferences.get('token')}");
      _state = DataState.loaded;
      notifyListeners();
    } catch (e) {
      _state = DataState.error;
    }
  }

  // Future<void> userLogout() async {
  //   _state = DataState.loading;
  //   notifyListeners();
  //   try {
  //     await _userAPI.logout();
  //     _state = DataState.loaded;
  //     notifyListeners();
  //   } catch (e) {
  //     _state = DataState.error;
  //   }
  // }

  // Future<void> getUser(int userId) async {
  //   _state = DataState.loading;
  //   notifyListeners();
  //   try {
  //     _user = await _userAPI.getUserDetail(userId);
  //     _state = DataState.loaded;
  //     notifyListeners();
  //   } catch (e) {
  //     _state = DataState.error;
  //   }
  // }

  // Future<bool> loadUserInfo() async {
  //   final token = _userAPI.getToken();
  //   _state = DataState.loading;
  //   // try {
  //   if (token == '') {
  //     userLogout();
  //     notifyListeners();
  //     return false;
  //   } else {
  //     _userAPI.getUserDetail(3596541099);
  //     _state = DataState.loaded;
  //     notifyListeners();
  //     return true;
  //   }
  //   // } catch (e) {
  //   //   _state = DataState.error;
  //   // }
  // }
}
