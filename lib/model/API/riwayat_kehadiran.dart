import 'package:dio/dio.dart';
import 'package:presencee/model/riwayat_dashboard.dart';
import 'privates.dart';
import 'package:presencee/model/riwayat_kehadiran_model.dart';

class KehadiranApi {
  static const String url = "$baseURL/v1/absens/riwayat";
  static const String urlDashboard = "$baseURL/v1/absens/dashboard";

  // Future<RiwayatDashboard> getKehadiran({required int idMhs, required String afterTime, required String beforeTime, required int jadwalId}) async {

  //   try {
  //     final response = await dio.get(
  //       urlDashboard,
  //       queryParameters: {
  //         "absen_id" : 0,
  //         "user_id" : idMhs,
  //         "mahasiswa_id" : 0,
  //         "jadwal_id" : jadwalId,
  //         "created_after" : "${afterTime}T00:00:00Z",
  //         "created_before" : "${beforeTime}T00:00:00Z",
  //         "is_konfirmasi" : true,
  //       },
  //       options: Options(headers: {
  //           'Content-Type': 'application/json; charset=UTF-8',
  //           'Authorization': 'Bearer $apiToken'
  //         })
  //     );

  //     print('response results = $response');

  //     if (response.statusCode == 200) {
  //       print(response.data);
  //       return RiwayatDashboard.fromJson(response.data);
  //     } else {
  //       throw Exception('Failed to load kehadiran');
  //     }
  //   } catch (e) {
  //     throw Exception('Failed to load kehadiran: $e');
  //   }
  // }

  static Future<RiwayatKehadiran> getKehadiranNew({required int idMhs, required String afterTime, required String beforeTime}) async {
  final dio = Dio();

    try {
      final response = await dio.get(
        url,
        queryParameters: {
          "absen_id" : 0,
          "user_id" : idMhs,
          "mahasiswa_id" : 0,
          "jadwal_id" : 0,
          "created_after" : afterTime,
          "created_before" : beforeTime,
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
  static Future<RiwayatDashboard> getKehadiran({required int idMhs, required String afterTime, required String beforeTime,required int jadwalId}) async {
    final dio = Dio();

    try {
      final response = await dio.get(
        urlDashboard,
        queryParameters: {
          "absen_id" : 0,
          "user_id" : idMhs,
          "mahasiswa_id" : 0,
          "jadwal_id" : jadwalId,
          "created_after" : afterTime,
          "created_before" : beforeTime,
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
        return RiwayatDashboard.fromJson(response.data);
      } else {
        throw Exception('Failed to load kehadiran');
      }
    } catch (e) {
      throw Exception('Failed to load kehadiran: $e');
    }
  }
}
