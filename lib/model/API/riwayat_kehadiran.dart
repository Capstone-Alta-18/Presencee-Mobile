import 'package:dio/dio.dart';
import 'package:presencee/model/riwayat_kehadiran_model.dart';

const String baseURL = "https://647eb234c246f166da8f47fa.mockapi.io/kehadiran";

class KehadiranApi {
  static const String url = baseURL;

  static Future<List<RiwayatKehadiran>> getKehadiran() async {
    final dio = Dio();

    try {
      final response = await dio.get(url);

      // log('response results = $response');

      if (response.statusCode == 200) {
        final datas = response.data;
        // log('datas: $datas');
        List<RiwayatKehadiran> kehadiran = List<RiwayatKehadiran>.from(
            datas.map((model) => RiwayatKehadiran.fromJson(model)));
        // log('kehadiran: $kehadiran');
        return kehadiran;
      } else {
        throw Exception('Failed to load kehadiran');
      }
    } catch (e) {
      throw Exception('Failed to load kehadiran: $e');
    }
  }
}
