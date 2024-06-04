import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_project_skripsi/features/dosen/model/dosen_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Dosen1Repo {
  static final baseUrl = dotenv.get("BASE_URL");

  static Future<List<Dosen>> fetchDosen(type) async {
    var client = http.Client();
    List<Dosen> listDosen = [];

    try {
      var response = await client.get(
        Uri.parse("$baseUrl/dosen"),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        List<dynamic> results = jsonResponse['result'];
        for (var item in results) {
          Dosen dosen = Dosen.fromMap(item);
          print(dosen);
          listDosen.add(dosen);
        }
      } else {
        debugPrint("Failed to load dosen: ${response.statusCode}");
      }

      return listDosen;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    } finally {
      client.close();
    }
  }
}
