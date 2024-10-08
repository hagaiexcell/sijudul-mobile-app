import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_project_skripsi/features/pengajuan/model/pengajuan_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PengajuanRepo {
  static final baseUrl = dotenv.get("BASE_URL");

  static Future<List<Pengajuan>> fetchAllPengajuan({query}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var client = http.Client();

    List<Pengajuan> listPengajuan = [];

    try {
      var response = await client
          .get(Uri.parse("$baseUrl/pengajuan/?judul=$query"), headers: {
        "Authorization": "Bearer ${prefs.getString('auth_token')}"
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        List<dynamic> results = jsonResponse['result'];
        // print(results);
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

  static Future<List<Pengajuan>> fetchAllPengajuanByIdMahasiswa(
      {id, query}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var client = http.Client();
    List<Pengajuan> listPengajuan = [];
    // print(query);
    try {
      var response = await client.get(
          Uri.parse("$baseUrl/pengajuan/mahasiswa/$id?judul=$query"),
          headers: {
            "Authorization": "Bearer ${prefs.getString('auth_token')}"
          });

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        List<dynamic> results = jsonResponse['result'];

        for (var item in results) {
          Pengajuan pengajuan = Pengajuan.fromMap(item);
          listPengajuan.add(pengajuan);
        }
      } else {
        throw Exception(jsonDecode(response.body)['error']);
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
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var client = http.Client();

    try {
      var response = await client.get(Uri.parse("$baseUrl/pengajuan/$id"),
          headers: {
            "Authorization": "Bearer ${prefs.getString('auth_token')}"
          });
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

  static Future createPengajuan(
      {id,
      peminatan,
      judul,
      tempatPenelitian,
      rumusanMasalah,
      dosen1Id,
      dosen2Id}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var client = http.Client();
    try {
      var body = jsonEncode({
        "mahasiswa_id": id,
        "peminatan": peminatan,
        "judul": judul,
        "tempat_penelitian": tempatPenelitian,
        "abstrak": rumusanMasalah,
        "dospem1_id": dosen1Id,
        "dospem2_id": dosen2Id,
        "status_acc": "Pending",
        "rejected_note": ""
      });

      var response = await client.post(Uri.parse("$baseUrl/pengajuan"),
          headers: {
            "Content-Type": "application/json",
            "Accept": "*/*",
            "Authorization": "Bearer ${prefs.getString('auth_token')}"
          },
          body: body);
      // print(response.statusCode);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        Map<String, dynamic> results = jsonResponse['result'];

        return Pengajuan.fromMap(results);
        // return true;
      } else if (response.statusCode == 307) {
        var redirectUrl = response.headers['location'];
        var redirectResponse = await client.post(
          Uri.parse("$baseUrl$redirectUrl"),
          headers: {
            "Content-Type": "application/json",
            "Accept": "*/*",
            "Authorization": "Bearer ${prefs.getString('auth_token')}"
          },
          body: body,
        );

        if (redirectResponse.statusCode == 200) {
          Map<String, dynamic> jsonResponse = jsonDecode(redirectResponse.body);
          Map<String, dynamic> results = jsonResponse['result'];
          return Pengajuan.fromMap(results);
          // return true;
        } else {
          // print("uhuuu ${jsonDecode(redirectResponse.body)['error']}");
          throw Exception(jsonDecode(redirectResponse.body)['error']);
        }
      } else {
        // print("uhuuu2 ${jsonDecode(response.body)['error']}");
        throw Exception(jsonDecode(response.body)['error']);
        // throw Exception('Failed to create pengajuan');
      }
    } catch (e) {
      rethrow;
    } finally {
      client.close();
    }
  }

  static Future similarityCheck(judul) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var client = http.Client();

    try {
      var body = jsonEncode({"judul": judul});

      var response = await client.post(
          Uri.parse("$baseUrl/pengajuan/similarity-test"),
          headers: {"Authorization": "Bearer ${prefs.getString('auth_token')}"},
          body: body);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      } else {
        throw Exception('Failed to Check Similarity');
      }
    } catch (e) {
      rethrow;
    }
  }
}
