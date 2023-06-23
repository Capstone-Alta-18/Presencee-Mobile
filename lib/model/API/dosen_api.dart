import 'package:dio/dio.dart';
import 'package:presencee/model/API/privates.dart';
import 'package:presencee/model/dosen_model.dart';

class DosenApi {
  static const String url = "$baseURL/v1/dosen";

  static Future<DosenModel> getDosenApi() async {
    final dio = Dio();
    try {
      final response = await dio.get('$url',
          options: Options(headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $apiToken'
          }));

      if (response.statusCode == 200) {
        // print(response.data);
        return DosenModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load data dosen...');
      }
    } catch (e) {
      throw Exception('Failed to load data dosen : $e');
    }
  }
}
