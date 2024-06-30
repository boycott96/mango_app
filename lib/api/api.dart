import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_test/pages/profile/device_init.dart';
import 'package:flutter_application_test/store/store.dart';

class ApiService {
  final Dio _dio = Dio();
  // final _prefix = "https://wp.larkdance.cn";
  // final _prefix = "http://47.111.178.168:9001";
  // final _prefix = "http://114.100.144.66:9002";
  // final _prefix = "http://192.168.110.11:9000";
  final _prefix = "http://192.168.1.235:9000";
  // final _prefix = "http://192.168.200.73:9000";
  ApiService(BuildContext context) {
    // 添加拦截器
    _dio.interceptors
        .add(InterceptorsWrapper(onResponse: (response, handler) async {
      // 如果响应状态码为401，则跳转到指定页面
      if (response.data['code'] == 401) {
        // 这里可以添加页面跳转的逻辑
        // 例如：Navigator.pushNamed(context, '/login');
        bool flag = await PageData.getInit();
        if (!flag) {
          PageData.saveInit(true);
          // ignore: use_build_context_synchronously
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const DeviceInit()));
        }
      }
      return handler.next(response);
    }));
  }

  Future<dynamic> get(String url) async {
    String? deviceId = await DeviceInfo.getDevcieId();
    _dio.options.headers['device-id'] = deviceId;
    String? token = await TokenManager.getToken();
    _dio.options.headers['Authorization'] = 'Bearer $token';
    Response response = await _dio.get(_prefix + url);
    return response;
  }

  Future<dynamic> post(String url, Object data) async {
    String? deviceId = await DeviceInfo.getDevcieId();
    _dio.options.headers['device-id'] = deviceId;
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
