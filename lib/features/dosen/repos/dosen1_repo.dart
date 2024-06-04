import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_project_skripsi/features/dosen/model/dosen_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Dosen1Repo {
  static final baseUrl = dotenv.get("BASE_URL");

  static Future<List<Dosen>> fetchDosen() async {
    var client = http.Client();
    List<Dosen> listDosen = [];

    try {
      var response = await client.get(
        Uri.parse("$baseUrl/dosen"),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        print(jsonResponse);
        // Ensure jsonResponse contains 'result' key and it is a list

        List<dynamic> results = jsonResponse['result'];
        print(results);
        for (var item in results) {
          if (item != null && item is Map<String, dynamic>) {
            Dosen dosen = Dosen.fromMap(item);
            listDosen.add(dosen);
          }
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
