import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_project_skripsi/features/dosen/model/dosen_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Dosen1Repo {
  static final baseUrl = dotenv.get("BASE_URL");

  static Future<List<Dosen>> fetchDosen(type) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var client = http.Client();
    List<Dosen> listDosen = [];

    try {
      var response = await client.get(Uri.parse("$baseUrl/dosen"), headers: {
        "Authorization": "Bearer ${prefs.getString('auth_token')}"
      });
      // print("dosenn");
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        List<dynamic> results = jsonResponse['result'];
        for (var item in results) {
          Dosen dosen = Dosen.fromMap(item);

          listDosen.add(dosen);
        }
      } else {
        throw Exception('Failed to load Dosen');
      }

      return listDosen;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    } finally {
      client.close();
    }
  }

  static Future<Dosen> fetchDosenById(id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var client = http.Client();

    try {
      var response = await client.get(Uri.parse("$baseUrl/dosen/$id"), headers: {
        "Authorization": "Bearer ${prefs.getString('auth_token')}"
      });
      // print("dosenn");
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        Map<String, dynamic> results = jsonResponse['dosen'];
        return Dosen.fromMap(results);
      } else {
        throw Exception('Failed to load Dosen');
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    } finally {
      client.close();
    }
  }
}
