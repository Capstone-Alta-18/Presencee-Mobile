import 'package:dio/dio.dart';
import 'package:presencee/model/API/privates.dart';
import 'package:presencee/model/user_model.dart';

class UserAPI {
  static const String url = "$baseURL/v1/users/login";
  final Dio dio = Dio();

  Future<User> userLogin(String email, String password) async {
    try {
      var response = await dio.post(url,
          // options: Options(headers: {
          //   'Content-Type': 'application/json; charset=UTF-8',
          //   'Authorization': 'Bearer $apiToken'
          // }),
          data: {'email': email, 'password': password});

      // log('response results = $response');

      if (response.statusCode == 200) {
        apiToken = response.data['token'];
        print(apiToken);
        // print('API TOKEN : $apiToken');
        // final datas = response.data['mahasiswas'];
        // final userLog = UserModel.fromJson(jsonDecode(response.data));

        // log('datas: $datas');
        // List<MahasiswaModel> mahasiswa = List<MahasiswaModel>.from(datas.map((model) => MahasiswaModel.fromJson(model)));
        // log('mahasiswa: $mahasiswa');
        // print(response.data);
        return User.fromJson(response.data);
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }

  // Future<User> getUserDetail(int userId) async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   try {
  //     var response = await dio.get('$baseURL/v1/users',
  //         queryParameters: {'user_id': userId},
  //         options: Options(headers: {
  //           'Content-Type': 'application/json; charset=UTF-8',
  //           'Authorization': 'Bearer ${sharedPreferences.get('token')}'
  //         }));
  //     if (response.statusCode == 200) {
  //       return User.fromJson(response.data);
  //     } else {
  //       throw Exception('Failed to get user detail');
  //     }
  //   } catch (e) {
  //     throw Exception('Failed to connect to the server: $e');
  //   }
  // }

  // Future<bool> logout() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   return await sharedPreferences.remove('token');
  // }

  // Future<String> getToken() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   return sharedPreferences.getString('token') ?? '';
  // }
}
