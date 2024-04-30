import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  static const String _tokenKey = 'token';

  static Future<void> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  static Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(_tokenKey);
    return token;
  }
}

class DeviceInfo {
  static const String _deviceInfo = 'device';

  static Future<void> saveInfo(Map<String, dynamic> obj) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_deviceInfo, jsonEncode(obj));
  }

  static Future<Map<String, dynamic>> getInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? deviceInfo = prefs.getString(_deviceInfo);
    return jsonDecode(deviceInfo!);
  }
}

class PageData {
  static const String _me = 'me';

  static Future<void> saveMeData(Map<String, dynamic> obj) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_me, jsonEncode(obj));
  }

  static Future<Map<String, dynamic>> getMeData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString(_me);
    return jsonDecode(data!);
  }
}
