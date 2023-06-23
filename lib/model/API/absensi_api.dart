import 'package:dio/dio.dart';
import 'package:presencee/model/API/privates.dart';
import 'package:presencee/model/absensi_model.dart';
import 'package:presencee/model/filter_absensi_model.dart';

class AbsensiAPI {
  static const String url = "$baseURL/v1/absens/";
  static const String urlabsen = "$baseURL/v1/absens/filter";
  final Dio dio = Dio();

  Future<Absensi> createAbsen(
      int userId,
      int mahasiswaId,
      int jadwalId,
      String timeAttemp,
      String matakuliah,
      String status,
      String location,
      String image) async {
    try {
      var response = await dio.post(
        url,
        options: Options(headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $apiToken'
        }),
        data: {
          'user_id': userId,
          'mahasiswa_id': mahasiswaId,
          'jadwal_id': jadwalId,
          'time_attemp': timeAttemp,
          'matakuliah': matakuliah,
          'status': status,
          'description': "",
          'location': location,
          'image': image,
          'is_konfirmasi': false,
        },
      );

      if (response.statusCode == 201) {
        return Absensi.fromJson(response.data);
      } else {
        throw Exception('Failed to create absen');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }

  Future<List<FilterAbsen>> getAbsen(
    int userId,
    int mahasiswaId,
    int jadwalId,
    String createdAfter,
    String createdBefore,
  ) async {
    try {
      var response = await dio.get(
        urlabsen,
        options: Options(headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $apiToken'
        }),
        queryParameters: {
          'absen_id': 0,
          'user_id': userId,
          'mahasiswa_id': mahasiswaId,
          'jadwal_id': jadwalId,
          'created_after': createdAfter,
          'created_before': createdBefore,
          'is_konfirmasi': false,
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> dataList = response.data['data'];
        List<FilterAbsen> filterAbsensi =
            dataList.map((json) => FilterAbsen.fromJson(json)).toList();
        return filterAbsensi;
      } else {
        throw Exception('Failed to get absen');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }
}
