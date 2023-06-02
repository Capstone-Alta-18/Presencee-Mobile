import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:presencee/model/API/privates.dart';
import 'package:presencee/model/mahasiswa_model.dart';

class MahasiswaApi {
  static const String url = "$baseURL/v1/mahasiswa";

  static Future<List<MahasiswaModel>> getMahasiswa() async {
    final dio = Dio();

    try {
      final response = await dio.get(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $apiToken'
          }
        )
      );

      // log('response results = $response');

      if (response.statusCode == 200) {
        final datas = response.data['mahasiswas'];
        // log('datas: $datas');
        List<MahasiswaModel> mahasiswa = List<MahasiswaModel>.from(datas.map((model) => MahasiswaModel.fromJson(model)));
        // log('mahasiswa: $mahasiswa');
        return mahasiswa;
      } else {
        throw Exception('Failed to load mahasiswa');
      }
    } catch (e) {
      throw Exception('Failed to load mahasiswa: $e');
    }
  }
  
}