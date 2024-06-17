import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_test/api/user.dart';
import 'package:flutter_application_test/pages/main_screen.dart';
import 'package:flutter_application_test/store/store.dart';

class DeviceInit extends StatefulWidget {
  const DeviceInit({super.key});

  @override
  State<DeviceInit> createState() => _DeviceInitState();
}

class _DeviceInitState extends State<DeviceInit> {
  @override
  void initState() {
    super.initState();
    initInfo(context);
  }

  void initInfo(context) async {
    Response response = await UserService(context).getInfo();
    if (response.data['code'] == 0) {
      var data = response.data['data'];
      print("data: $data");
      if (data['accessToken'] != null) {
        TokenManager.saveToken(data['accessToken']);
      }
      PageData.saveMeData(data['info']);
      PageData.saveInit(false);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const MainScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          width: 40, // 设置加载圈的宽度
          height: 40, // 设置加载圈的高度
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
