// import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_project_skripsi/features/notifications/model/notifications_model.dart';
// import 'package:flutter_project_skripsi/features/pengajuan/model/pengajuan_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileRepo {
  static final baseUrl = dotenv.get("BASE_URL");

  static Future updateProfile({id, name, email}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var client = http.Client();

    // List<Notifications> listNotification = [];

    try {
      var body = jsonEncode({"name": name, "email": email});
      var response = await client.put(Uri.parse("$baseUrl/mahasiswa/$id"),
          body: body,
          headers: {
            "Authorization": "Bearer ${prefs.getString('auth_token')}"
          });

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      } else {
        throw Exception("Failed to load Profile");
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future getProfile({id}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var client = http.Client();

    // List<Notifications> listNotification = [];

    try {
      var response = await client.get(Uri.parse("$baseUrl/mahasiswa/$id"),
          headers: {
            "Authorization": "Bearer ${prefs.getString('auth_token')}"
          });

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      } else {
        throw Exception("Failed to load Profile");
      }
    } catch (e) {
      rethrow;
    }
  }
}
