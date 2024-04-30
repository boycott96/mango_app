import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter_application_test/store/store.dart';

class ApiService {
  final Dio _dio = Dio();
  final _prefix = "http://192.168.1.235:9000";

  Future<dynamic> get(String url) async {
    String? token = await TokenManager.getToken();
    _dio.options.headers['Authorization'] = 'Bearer $token';
    Response response = await _dio.get(_prefix + url);
    return response;
  }

  Future<dynamic> post(String url, Object data) async {
    String? token = await TokenManager.getToken();
    _dio.options.headers['Authorization'] = 'Bearer $token';
    Response response = await _dio.post(_prefix + url, data: data);
    return response;
  }
}

class R<T> {
  late int code;
  late String msg;
  late T data;
}
