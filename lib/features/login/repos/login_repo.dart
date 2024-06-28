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

      var response = await client
          .post(Uri.parse("$baseUrl/auth/mahasiswa/login"), body: body);

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

  static Future registerMahasiswa(
    String name,
    String nim,
    String email,
    String password,
    String prodi,
    int? angkatan,
    int? sks,
    String tempatLahir,
    String? tanggalLahir,
    String jenisKelamin,
    String agama,
    // String notelpon
  ) async {
    var client = http.Client();
    try {
      var body = jsonEncode({
        "angkatan": angkatan,
        "email": email,
        "name": name,
        "nim": nim,
        "password": password,
        "prodi": prodi,
        "sks": sks,
        // "image": "",
        "tempat_lahir": tempatLahir,
        "tanggal_lahir": tanggalLahir,
        "jenis_kelamin": jenisKelamin,
        "agama": agama,

        // "no_telpon": notelpon
      });
      // print('Request Body: $body');

      var response =
          await client.post(Uri.parse("$baseUrl/mahasiswa"), body: body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        // print('Response Body: $jsonResponse');
        Map<String, dynamic> results = jsonResponse['result'];
        return results;
        // Handle 'results' as needed
      } else if (response.statusCode == 307) {
        var redirectUrl = response.headers['location'];
        // print('Redirecting to: $redirectUrl');
        var redirectResponse = await client.post(
          Uri.parse("$baseUrl$redirectUrl"),
          body: body,
        );

        if (redirectResponse.statusCode == 200) {
          Map<String, dynamic> jsonResponse = jsonDecode(redirectResponse.body);
          // print('Redirect Response Body: $jsonResponse');
          Map<String, dynamic> results = jsonResponse['result'];
          return results;
          // Handle 'results' as needed
        } else if (redirectResponse.statusCode == 400 &&
            jsonDecode(redirectResponse.body).containsKey('error')) {
          Map<String, dynamic> jsonResponse = jsonDecode(redirectResponse.body);

          return jsonResponse;
        }
      } else {
        throw Exception('Failed to create Mahasiswa: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    } finally {
      client.close();
    }
  }
}
