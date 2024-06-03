import 'dart:convert';
// import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_project_skripsi/features/login/model/user_model.dart';


class LoginRepo {
  static final baseUrl = dotenv.get("BASE_URL");

  static Future loginMahasiswa(String nim, String password) async {
    var client = http.Client();
    try {
      var body = jsonEncode({"nim": nim, "password": password});

      var response = await client.post(
          Uri.parse("${baseUrl}mahasiswa/login"),
          body: body);

      // Check if response status code is in the success range
      if (response.statusCode >= 200 && response.statusCode < 300) {
        var jsonResponse = jsonDecode(response.body);
        var userData = jsonResponse['data'];
        var token = jsonResponse['token'];
        return User.fromJson(userData, token);
      } else {
        // If response status code is not in the success range, return error
        var jsonResponse = jsonDecode(response.body);

        return {"error": "${jsonResponse['error']}"};
      }
    } catch (e) {
      // Catch any network exceptions
      // debugPrint("Network error: " + e.toString());
      // return false;
      return {"error": "Network error: $e"};
    } finally {
      client.close();
    }
  }
}


