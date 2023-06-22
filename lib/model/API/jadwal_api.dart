import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:presencee/model/API/privates.dart';
import '../jadwal_model.dart';

class JadwalApi {
  static const String url = "$baseURL/v1/jadwals";

  static Future<List<Data>> getPageJadwal(
      {required int pages, required int limits}) async {
    final dio = Dio();

    try {
      final response = await dio.get(url,
          options: Options(headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $apiToken'
          }),
          queryParameters: {
            'page': pages,
            'limit': limits,
          });

      // print('response results = $response');

      if (response.statusCode == 200) {
        final datas = response.data['data'];
        List<Data> jadwalList =
            List<Data>.from(datas.map((model) => Data.fromJson(model)));
        // log("Results >> ${jadwalList[0].name}");
        return jadwalList;
      } else {
        throw Exception('Failed to load All jadwal...');
      }
    } catch (e) {
      throw Exception('Failed to load jadwal: $e');
    }
  }

  static Future<List<Data>> getFilterJadwal(
      {required int userId,
      required String jamAfter,
      required String jamBefore}) async {
    final dio = Dio();

    try {
      final response = await dio.get('$url/filter',
          options: Options(headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $apiToken'
          }),
          queryParameters: {
            // 'page': pages,
            // 'limit': limits,
            'jadwal_id': 0,
            'user_id': userId,
            'dosen_id': 0,
            'matakuliah_id': 0,
            'jam_after': jamAfter,
            'jam_before': jamBefore,
            'room_id': 0,
          });

      // print('response results = $response');

      if (response.statusCode == 200) {
        final datas = response.data['data'];
        List<Data> listJadwal =
            List<Data>.from(datas.map((model) => Data.fromJson(model)));
        // log("Results FIlter>> ${response.data['data']}");
        return listJadwal;
      } else {
        throw Exception('Failed to load filter jadwal...');
      }
    } catch (e) {
      throw Exception('Failed to load filter jadwal: $e');
    }
  }

  static Future<List<Data>> getFilterJadwalSemua(
      {required int userId,
      required String jamAfter,
      required String jamBefore}) async {
    final dio = Dio();

    try {
      final response = await dio.get('$url/filter',
          options: Options(headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $apiToken'
          }),
          queryParameters: {
            // 'page': pages,
            // 'limit': limits,
            'jadwal_id': 0,
            'user_id': userId,
            'dosen_id': 0,
            'matakuliah_id': 0,
            'jam_after': jamAfter,
            'jam_before': jamBefore,
            'room_id': 0,
          });

      // print('response results = $response');

      if (response.statusCode == 200) {
        final datas = response.data['data'];
        List<Data> listJadwalSemua =
            List<Data>.from(datas.map((model) => Data.fromJson(model)));
        // log("Results Filter Semua>> ${response.data['data']}");
        return listJadwalSemua;
      } else {
        throw Exception('Failed to load filter jadwal...');
      }
    } catch (e) {
      throw Exception('Failed to load filter jadwal: $e');
    }
  }
}
