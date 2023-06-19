import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:presencee/model/API/privates.dart';
import 'package:presencee/model/upload_model.dart';

class UploadImageAPI {
  static const String url = "$baseURL/v1/upload/";
  final Dio dio = Dio();

  Future<UploadImage> uploadImage(XFile file) async {
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap(
        {"image": await MultipartFile.fromFile(file.path, filename: fileName)});
    try {
      var response = await dio.post(url, data: formData);

      if (response.statusCode == 200) {
        print(response.data);
        return UploadImage.fromJson(response.data);
      } else {
        throw Exception('Failed to upload image');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }
}
