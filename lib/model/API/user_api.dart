import 'package:dio/dio.dart';
import 'package:presencee/model/API/privates.dart';
import 'package:presencee/model/user_model.dart';

class UserAPI {
  static const String url = "$baseURL/v1/users/login";
  final Dio dio = Dio();

  Future<User> userLogin(String email, String password) async {
    try {
      var response = await dio.post(
        url,
        data: {'email': email, 'password': password});

      if (response.statusCode == 200) {
        apiToken = response.data['token'];
        return User.fromJson(response.data);
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }
}
