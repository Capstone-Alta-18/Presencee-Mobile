import 'dart:convert';
import 'package:dio/dio.dart';
import 'privates.dart';
import 'package:presencee/model/riwayat_kehadiran_model.dart';

class KehadiranApi {
  static const String url = "$baseURL/v1/absens/riwayat";

  static Future<List<RiwayatKehadiran>> getKehadiran() async {
    final dio = Dio();

    try {
      final response = await dio.get(
        url,
        queryParameters: {
          "absen_id" : 0,
          "user_id" : 0,
          "mahasiswa_id" : 35,
          "jadwal_id" : 0,
          "created_after" : "2023-06-02T15:04:05Z",
          "created_before" : "2023-06-20T15:04:05Z",
          "is_konfirmasi" : true,
        },
        options: Options(headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $apiToken'
          })
      );

      // print('response results = $response');

      if (response.statusCode == 200) {
        final datas = response as List;
        // print('response data : ${datas}');
        List<RiwayatKehadiran> kehadiran = (jsonDecode(response.data) as List).map((model) => RiwayatKehadiran.fromJson(model)).toList();
        // List<RiwayatKehadiran> kehadiran = List<RiwayatKehadiran>.from(
        //     datas.map((model) => RiwayatKehadiran.fromJson(model))).toList();
        // print('kehadiran: $kehadiran');
        return kehadiran;
      } else {
        throw Exception('Failed to load kehadiran');
      }
    } catch (e) {
      throw Exception('Failed to load kehadiran: $e');
    }
  }

  static Future<RiwayatKehadiran> getKehadiranNew({required int idMhs}) async {
    final dio = Dio();

    try {
      final response = await dio.get(
        url,
        queryParameters: {
          "absen_id" : 0,
          "user_id" : 0,
          "mahasiswa_id" : idMhs,
          "jadwal_id" : 0,
          "created_after" : "2023-06-02T15:04:05Z",
          "created_before" : "2023-06-20T15:04:05Z",
          "is_konfirmasi" : true,
        },
        options: Options(headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $apiToken'
          })
      );

      // print('response results = $response');

      if (response.statusCode == 200) {
        print(response.data);
        return RiwayatKehadiran.fromJson(response.data);
      } else {
        throw Exception('Failed to load kehadiran');
      }
    } catch (e) {
      throw Exception('Failed to load kehadiran: $e');
    }
  }
}
