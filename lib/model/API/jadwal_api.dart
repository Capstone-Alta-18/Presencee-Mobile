import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:presencee/model/API/privates.dart';
import '../jadwal_model.dart';

class JadwalApi {
  static const String url = "$baseURL/v1/jadwals";
  
  static Future<List<JadwalPelajaran>> getPageJadwal({required int pages, required int limits}) async {
    final dio = Dio();

    try {
      final response = await dio.get(
        url,
        options: Options(headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $apiToken'
        }),
        queryParameters: {
          'page': pages,
          'limit': limits,
        }
      );

      // print('response results = $response');
      
      if (response.statusCode == 200) {
        final datas = response.data['data'];
        List<JadwalPelajaran> jadwalList = List<JadwalPelajaran>.from(datas.map((model) => JadwalPelajaran.fromJson(model)));
        // log("Results >> ${jadwalList[0].name}");
        return jadwalList;
      } else {
        throw Exception('Failed to load All jadwal...');
      }
    } catch (e) {
      throw Exception('Failed to load jadwal: $e');
    }
  }
}