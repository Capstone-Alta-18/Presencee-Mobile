import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:presencee/model/API/privates.dart';
import 'package:presencee/model/absensi_model.dart';

class AbsensiAPI {
  static const String url = "$baseURL/v1/absens/";
  static const String imageUrl = "$baseURL/v1/upload/";
  final Dio dio = Dio();

  Future<Absensi> createAbsen(
    int user_id,
    int mahasiswa_id,
    int jadwal_id,
    String time_attemp,
    String matakuliah,
    String status,
    String location,
    String image,
  ) async {
    try {
      var response = await dio.post(
        url,
        options: Options(headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $apiToken'
        }),
        data: {
          'user_id': user_id,
          'mahasiswa_id': mahasiswa_id,
          'jadwal_id': jadwal_id,
          'time_attemp': time_attemp,
          'matakuliah': matakuliah,
          'status': status,
          'location': location,
          'image': image,
          'is_konfirmasi': false,
        },
      );

      // log('response results = $response');

      if (response.statusCode == 201) {
        // final datas = response.data;
        // final userLog = UserModel.fromJson(jsonDecode(response.data));

        // log('datas: $datas');
        // List<MahasiswaModel> mahasiswa = List<MahasiswaModel>.from(datas.map((model) => MahasiswaModel.fromJson(model)));
        // log('mahasiswa: $mahasiswa');
        return Absensi.fromJson(response.data);
      } else {
        throw Exception('Failed to create absen');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }

  Future<Absensi> uploadImage(XFile image) async {
    try {
      var response = await dio.post(
        imageUrl,
        data: {'image': image},
      );

      if (response.statusCode == 201) {
        return Absensi.fromJson(response.data);
      } else {
        throw Exception('Failed to upload image');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }
}
