// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_project_skripsi/features/notifications/model/notifications_model.dart';
// import 'package:flutter_project_skripsi/features/pengajuan/model/pengajuan_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileRepo {
  static final baseUrl = dotenv.get("BASE_URL");

  static Future updateProfile(
      {id,
      name,
      email,
      tempatLahir,
      String? tanggalLahir,
      jenisKelamin,
      agama,
      noTelpon}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var client = http.Client();

    // List<Notifications> listNotification = [];

    try {
      var body = jsonEncode({
        "name": name,
        "email": email,
        "tempat_lahir": tempatLahir,
        "tanggal_lahir": tanggalLahir,
        "jenis_kelamin": jenisKelamin,
        "agama": agama,
        "no_telp": noTelpon
      });
      var response = await client
          .put(Uri.parse("$baseUrl/mahasiswa/$id"), body: body, headers: {
        "Authorization": "Bearer ${prefs.getString('auth_token')}",
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        // print(jsonResponse['result']);
        return jsonResponse['result'];
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
