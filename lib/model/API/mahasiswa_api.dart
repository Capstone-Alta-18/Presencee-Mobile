import 'package:dio/dio.dart';
import 'package:presencee/model/API/privates.dart';
import 'package:presencee/model/mahasiswa_model.dart';

class MahasiswaAll {
  static const String url = "$baseURL/v1/mahasiswa";

  static Future<List<Mahasiswas>> getMahasiswa() async {
    final dio = Dio();
    try {
      final response = await dio.get(url,
          options: Options(headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $apiToken'
          }));

      // log('response results = $response');

      if (response.statusCode == 200) {
        final datas = response.data['mahasiswas'];
        // log('datas: $datas');
        List<Mahasiswas> siswaList = List<Mahasiswas>.from(
            datas.map((model) => Mahasiswas.fromJson(model)));
        // log('mahasiswa: $siswaList');
        return siswaList;
      } else {
        throw Exception('Failed to load All mahasiswa...');
      }
    } catch (e) {
      throw Exception('Failed to load mahasiswa: $e');
    }
  }
}

class MahasiswaOne {
  static const String url = "$baseURL/v1/mahasiswa";

  static Future<Mahasiswas> getOneMahasiswa({required int oneId}) async {
    final dio = Dio();
    try {
      final response = await dio.get('$url/$oneId',
          queryParameters: {
            'id': oneId,
          },
          options: Options(headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $apiToken'
          }));
      // log('response results = $response');

      if (response.statusCode == 200) {
        final datas = response.data['mahasiswa'];
        // log('datas: $datas');
        // List<Mahasiswas> siswaList = List<Mahasiswas>.from(datas.map((model) => Mahasiswas.fromJson(model)));
        // log('>> Data mahasiswa= $siswaList');
        return Mahasiswas.fromJson(datas);
      } else {
        throw Exception('Failed to load single mahasiswa...');
      }
    } catch (e) {
      throw Exception('Failed to load single mahasiswa: $e');
    }
  }
}
