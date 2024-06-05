import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_project_skripsi/features/dosen/model/dosen_model.dart';
import 'package:flutter_project_skripsi/features/pengajuan/model/pengajuan_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PengajuanRepo {
  static final baseUrl = dotenv.get("BASE_URL");

  static Future<List<Pengajuan>> fetchAllPengajuan() async {
    var client = http.Client();
    List<Pengajuan> listPengajuan = [];

    try {
      var response = await client.get(
        Uri.parse("$baseUrl/pengajuan"),
      );
      print(response);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        List<dynamic> results = jsonResponse['result'];
        for (var item in results) {
          Pengajuan pengajuan = Pengajuan.fromMap(item);
          listPengajuan.add(pengajuan);
        }
      } else {
        throw Exception('Failed to load pengajuan');
      }

      return listPengajuan;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    } finally {
      client.close();
    }
  }

  static Future<Pengajuan> fetchPengajuanById(id) async {
    var client = http.Client();

    try {
      var response = await client.get(
        Uri.parse("$baseUrl/pengajuan/$id"),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        Map<String, dynamic> results = jsonResponse['result'];
       return Pengajuan.fromMap(results);
      } else {
        throw Exception('Failed to load pengajuan');
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    } finally {
      client.close();
    }
  }
}
