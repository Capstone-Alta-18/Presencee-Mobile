import 'package:dio/dio.dart';
import 'package:presencee/model/API/privates.dart';
import 'package:presencee/model/mahasiswa_model.dart';

class MahasiswaAPI {
  static const String url = "$baseURL/v1/mahasiswa";

  static Future<List<Mahasiswas>> getMahasiswa() async {
    final dio = Dio();
    try {
      final response = await dio.get(url,
          options: Options(headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $apiToken'
          }));

      if (response.statusCode == 200) {
        final datas = response.data['mahasiswas'];
        List<Mahasiswas> siswaList = List<Mahasiswas>.from(
            datas.map((model) => Mahasiswas.fromJson(model)));
        return siswaList;
      } else {
        throw Exception('Failed to load All mahasiswa...');
      }
    } catch (e) {
      throw Exception('Failed to load mahasiswa: $e');
    }
  }

  static Future<Mahasiswas> getOneMahasiswa({required int oneId}) async {
    final dio = Dio();
    try {
      final response = await dio.get('$url/$oneId',
          queryParameters: {
            'ID': oneId,
          },
          options: Options(headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $apiToken'
          }));
      if (response.statusCode == 200) {
        return Mahasiswas.fromJson(response.data['mahasiswa']);
      } else {
        throw Exception('Failed to load single mahasiswa...');
      }
    } catch (e) {
      throw Exception('Failed to load single mahasiswa: $e');
    }
  }

  static Future<MahasiswaStatus> updateMahasiswa(
      {required int idMahasiswa,
      required String name,
      required String email,
      required String nim,
      required String image,
      required String phone,
      required String jurusan,
      required String tahunMasuk,
      required String ipk,
      required int userId}) async {
    final dio = Dio();
    try {
      final response = await dio.put(
        '$url/$idMahasiswa',
        queryParameters: {
          'id': idMahasiswa,
        },
        options: Options(headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $apiToken'
        }),
        data: {
          'name': name,
          'email': email,
          'nim': nim,
          'image': image,
          'phone': phone,
          'jurusan': jurusan,
          'tahun_masuk': tahunMasuk,
          'ipk': ipk,
          'user_id': userId
        },
      );
      if (response.statusCode == 200) {
        return MahasiswaStatus.fromJson(response.data['status']);
      } else {
        throw Exception('Failed to update mahasiswa...');
      }
    } catch (e) {
      throw Exception('Failed to update mahasiswa: $e');
    }
  }
}
