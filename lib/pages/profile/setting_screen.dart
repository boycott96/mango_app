import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_test/api/token_manager.dart';
import 'package:flutter_application_test/api/user.dart';
import 'package:flutter_application_test/pages/profile/profile_data.dart';

import 'none_setting.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  var flag = false;

  @override
  void initState() {
    handleProfile();
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  void handleProfile() async {
    String? token = await TokenManager.getToken();
    if (token != null) {
      // 访问用户数据
      Response res = await UserService().getInfo();
      print(token);
      print("###");
      print(res.data);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (flag) {
      return const ProfileData();
    }
    return const NoneSetting();
  }
}
