import 'package:dio/dio.dart';
import 'package:presencee/model/API/privates.dart';
import 'package:presencee/model/user_model.dart';

class UserAPI {
  static const String url = "$baseURL/v1/users/login";

  Future<User> userLogin(String email, String password) async {
    final Dio dio = Dio();

    try {
      var response = await dio.post(url,
          // options: Options(headers: {
          //   'Content-Type': 'application/json; charset=UTF-8',
          //   'Authorization': 'Bearer $apiToken'
          // }),
          data: {'email': email, 'password': password});

      // log('response results = $response');

      if (response.statusCode == 200) {
        // final datas = response.data['mahasiswas'];
        // final userLog = UserModel.fromJson(jsonDecode(response.data));

        // log('datas: $datas');
        // List<MahasiswaModel> mahasiswa = List<MahasiswaModel>.from(datas.map((model) => MahasiswaModel.fromJson(model)));
        // log('mahasiswa: $mahasiswa');
        return User.fromJson(response.data);
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }
}
