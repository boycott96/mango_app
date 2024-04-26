import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_test/api/token_manager.dart';
import 'package:flutter_application_test/api/user.dart';
import 'package:flutter_application_test/components/toast_manager.dart';
import 'package:flutter_application_test/pages/main_screen.dart';
import 'package:flutter_application_test/pages/profile/reset_screen.dart';
import 'package:flutter_application_test/pages/profile/signup_screen.dart';
import 'package:flutter_application_test/utils/util.dart';
import 'package:flutter_application_test/utils/validate.dart';
import 'package:dio/dio.dart';
import 'package:toast/toast.dart';

import '../../api/api.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SigninState();
}

class _SigninState extends State<SignIn> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final TextEditingController _pwdController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String? _errEmail;
  String? _errPwd;

  bool _showPwd = true;

  void _submitData(BuildContext context) async {
    var email = _emailController.text;
    var password = _pwdController.text;
    _errEmail = validateEmail(email);
    _errPwd = validateRequired(password);
    if (_errEmail == '' || _errPwd == '') {
      return;
    }
    if (mounted) {
      Response res =
          await UserService().signIn({"email": email, "password": hashPassword(password)});
      print("####");
      print(res);
      if (res.data['code'] == 0) {
        TokenManager.saveToken(res.data['accessToken']);
        ToastManager.showToast("login sucess!");
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const MainScreen()));
      } else {
        ToastManager.showToast(res.data['msg']);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(21, 72, 21, 10),
              child: SizedBox(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Email address',
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(30),
                    ), // 设置外边框为none
                    contentPadding: const EdgeInsets.symmetric(horizontal: 23),
                    filled: true, // 设置为 true 表示填充背景色
                    fillColor: const Color.fromRGBO(246, 247, 249, 1),
                    errorText: _errEmail,
                  ),
                  controller: _emailController,
                  onChanged: (value) {
                    setState(() {
                      _errEmail = validateEmail(value);
                    });
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 10),
              child: SizedBox(
                child: TextField(
                  obscureText: _showPwd,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(30),
                    ), // 设置外边框为none
                    contentPadding: const EdgeInsets.symmetric(horizontal: 23),
                    filled: true, // 设置为 true 表示填充背景色
                    fillColor: const Color.fromRGBO(246, 247, 249, 1),
                    errorText: _errPwd,
                    // 可选：设置密码可见/隐藏的图标
                    suffixIcon: IconButton(
                      icon: Icon(
                          _showPwd ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _showPwd = !_showPwd;
                        });
                      },
                    ),
                    // 可选：点击图标切换密码可见/隐藏状态
                  ),
                  controller: _pwdController,
                  onChanged: (value) {
                    setState(() {
                      _errPwd = validateRequired(value);
                    });
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 90, 20, 4),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Forgot password?",
                      style: const TextStyle(
                        color: Color.fromRGBO(255, 93, 151, 1),
                        fontSize: 14,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ResetPage()));
                        },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: SizedBox(
                width: double.infinity,
                height: 46,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color?>(
                        const Color.fromRGBO(255, 93, 151, 1)),
                  ),
                  onPressed: () {
                    _submitData(context);
                  },
                  child: const Text(
                    "Done",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: const TextSpan(
                      text: "Don't have account?",
                      style: TextStyle(
                        color: Color.fromRGBO(171, 173, 189, 1),
                        fontSize: 14,
                      ),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: "Sign up Now",
                      style: const TextStyle(
                        color: Color.fromRGBO(255, 93, 151, 1),
                        fontSize: 14,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Singup()));
                        },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
