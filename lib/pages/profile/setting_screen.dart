import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_test/api/user.dart';
import 'package:flutter_application_test/components/toast_manager.dart';
import 'package:flutter_application_test/pages/profile/profile_data.dart';
import 'package:flutter_application_test/store/store.dart';
import 'package:toast/toast.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  bool isLoading = true; // 添加一个状态用于表示是否正在加载用户信息
  bool hasError = false; // 添加一个状态用于表示是否发生了错误
  late Map<String, dynamic> userInfo;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    // 在初始化时调用 handleProfile 方法
    handleProfile(context);
  }

  void handleProfile(BuildContext context) async {
    try {
      String? token = await TokenManager.getToken();
      if (token != null && token != '') {
        // 访问用户数据
        Response res = await UserService(context).getInfo();
        await PageData.saveMeInit(true);
        if (res.data['code'] == 0) {
          setState(() {
            isLoading = false;
            userInfo = res.data['data'];
            PageData.saveMeData(userInfo);
          });
        } else {
          setState(() {
            isLoading = false;
            hasError = true;
          });
          TokenManager.saveToken("");
          ToastManager.showToast(res.data['msg']);
        }
      } else {
        setState(() {
          isLoading = false;
          hasError = true;
        });
      }
      // ignore: empty_catches
    } catch (e) {}
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    // 如果加载完成且没有错误，则显示用户信息页面
    return ProfileData(profile: userInfo);
  }
}
