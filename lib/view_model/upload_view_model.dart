import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:presencee/model/API/upload_api.dart';
import 'package:presencee/model/upload_model.dart';

enum DataState {
  initial,
  loading,
  loaded,
  error,
}

class UploadImageViewModel extends ChangeNotifier {
  final UploadImageAPI _uploadImageAPI = UploadImageAPI();
  UploadImage? _image;
  DataState _state = DataState.initial;
  UploadImage? get image => _image;

  DataState get state => _state;

  Future<void> uploadImage(XFile file) async {
    _state = DataState.loading;
    notifyListeners();
    try {
      _image = await _uploadImageAPI.uploadImage(file);

      _state = DataState.loaded;
      notifyListeners();
    } catch (e) {
      _state = DataState.error;
      notifyListeners();
    }
  }
}
