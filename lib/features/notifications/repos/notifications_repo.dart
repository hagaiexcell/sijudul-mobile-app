import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_project_skripsi/features/pengajuan/model/pengajuan_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsRepo {
  static final baseUrl = dotenv.get("BASE_URL");

  // static 
}
