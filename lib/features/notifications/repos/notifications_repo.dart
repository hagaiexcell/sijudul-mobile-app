// import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_project_skripsi/features/notifications/model/notifications_model.dart';
// import 'package:flutter_project_skripsi/features/pengajuan/model/pengajuan_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsRepo {
  static final baseUrl = dotenv.get("BASE_URL");

  static Future<List<Notifications>> fetchAllNotifications() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var client = http.Client();

    List<Notifications> listNotification = [];

    try {
      var response = await client.get(Uri.parse("$baseUrl/notification"),
          headers: {
            "Authorization": "Bearer ${prefs.getString('auth_token')}"
          });

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        // print(jsonResponse);
        List<dynamic> results = jsonResponse['result'];
        // print("$results sjfhjsfhj");
        for (var item in results) {
          // print("heyyyyyyyy");
          Notifications notification = Notifications.fromMap(item);
          // print(item['CreatedAt']);
          // print(notification.createdAt);
          listNotification.add(notification);
        }
      } else {
        throw Exception("Failed to load notifications");
      }

      return listNotification;
    } catch (e) {
      rethrow;
    }
  }
}
