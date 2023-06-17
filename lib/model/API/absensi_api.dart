import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:presencee/model/API/privates.dart';
import 'package:presencee/model/absensi_model.dart';

class AbsensiAPI {
  static const String url = "$baseURL/v1/absens/";
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
        print('ABSENSI : ${response.data}');
        return Absensi.fromJson(response.data);
      } else {
        throw Exception('Failed to create absen');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }
}
