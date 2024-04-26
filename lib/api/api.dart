import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_test/components/toast_manager.dart';

import 'token_manager.dart';

class ApiService {
  final Dio _dio = Dio();
  final _prefix = "http://192.168.1.235:9000";

  Future<dynamic> get(String url) async {
    String? token = await TokenManager.getToken();
    if (token != null) _dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      Response response = await _dio.get(_prefix + url);
      return response.data;
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("Error occurred: $error stackTrace: $stacktrace");
      }
      return null;
    }
  }

  Future<dynamic> post(String url, Object data) async {
    String? token = await TokenManager.getToken();
    if (token != null) _dio.options.headers['Authorization'] = 'Bearer $token';
    Response<R> response = await _dio.post(_prefix + url, data: data);
    if (response.data?.code != 0) {
      ToastManager.showToast(response.data!.msg);
    }
    return response.data;
  }
}

class R<T> {
  late int code;
  late String msg;
  late T data;
}
