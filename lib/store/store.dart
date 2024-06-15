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
  static const String _deviceId = 'device';

  static Future<void> saveInfo(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_deviceId, id);
  }

  static Future<String?> getDevcieId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? deviceId = prefs.getString(_deviceId);
    return deviceId;
  }
}

class PageData {
  static const String _me = 'me';
  static const String _meInit = 'me_init';

  static Future<void> saveInit(bool flag) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_meInit, flag);
  }

  static Future<bool> getInit() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? res = prefs.getBool(_meInit);
    if (res != null && res) {
      return true;
    }
    return false;
  }

  static Future<void> saveMeData(Map<String, dynamic> obj) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_me, jsonEncode(obj));
  }

  static Future<Map<String, dynamic>> getMeData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString(_me);
    if (data == null) {
      return {
        'avatarUrl': 'https://wp.larkdance.cn/file/image/default_avatar.jpg',
        'name': 'Hello World',
        'location': 'hefei'
      };
    }
    return jsonDecode(data);
  }
}
