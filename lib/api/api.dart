import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_test/pages/none_user.dart';
import 'package:flutter_application_test/store/store.dart';

class ApiService {
  final Dio _dio = Dio();
  final _prefix = "https://www.larkdance.cn/api";

  ApiService(BuildContext context) {
    // 添加拦截器
    _dio.interceptors.add(InterceptorsWrapper(onResponse: (response, handler) {
      // 如果响应状态码为401，则跳转到指定页面
      if (response.data['code'] == 401) {
        // 这里可以添加页面跳转的逻辑
        // 例如：Navigator.pushNamed(context, '/login');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const NoneUser()));
      }
      return handler.next(response);
    }));
  }

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
