import 'dart:convert';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Singup extends StatefulWidget {
  const Singup({super.key});

  @override
  State<Singup> createState() => _SignUpState();
}

class _SignUpState extends State<Singup> with SingleTickerProviderStateMixin {
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  final TextEditingController _cpwdController = TextEditingController();

  late AnimationController _controller;
  String _errCode = "";
  String _errEmail = "";
  String _errPwd = "";
  String _errCpwd = "";

  String? _validateCode(String? value) {
    if (value == null || value == '') {
      return 'This Code is required';
    }
    return "";
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    // 使用正则表达式检查邮箱格式
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return "";
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    // 使用正则表达式检查密码格式
    final passwordRegExp = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{4,20}$');
    if (!passwordRegExp.hasMatch(value)) {
      return 'Password must have 1 letter & 1 number, 4-20 chars';
    }
    return "";
  }

  void _submitData() async {
    final String invitationCode = _codeController.text;
    final String email = _emailController.text;
    final String password = _pwdController.text;
    final String confirmPwd = _cpwdController.text;
    setState(() {
      _errCode = _validateCode(invitationCode)!;
      _errEmail = _validateEmail(email)!;
      _errPwd = _validatePassword(password)!;
      if (password != confirmPwd) {
        _errCpwd = 'The two passwords are different';
      } else {
        _errCpwd = "";
      }
    });
    if (_errCode != '' || _errEmail != '' || _errPwd != '' || _errCpwd != '') {
      return;
    }
    var url = Uri.parse("http://192.168.1.235:9000/user/sign/up");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer YourAuthToken',
    };
    Map<String, dynamic> data = {"email": email, "password": password};

    var response =
        await http.post(url, headers: headers, body: json.encode(data));
    print(response);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    print(await http.read(Uri.https('example.com', 'foobar.txt')));
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome Sign up"),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(21, 72, 21, 10),
              child: SizedBox(
                height: 56,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(246, 247, 249, 1),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Invitation Code',
                      border: InputBorder.none, // 设置外边框为none
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 23),
                      errorText: _errCode,
                    ),
                    controller: _codeController,
                    onChanged: (value) {
                      setState(() {
                        _errCode = _validateCode(value)!;
                      });
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 10),
              child: SizedBox(
                height: 56,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(246, 247, 249, 1),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Email',
                      border: InputBorder.none, // 设置外边框为none
                      errorText: _errEmail,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 23),
                    ),
                    controller: _emailController,
                    onChanged: (value) {
                      setState(() {
                        _errEmail = _validateEmail(value)!;
                      });
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 10),
              child: SizedBox(
                height: 56,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(246, 247, 249, 1),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Password',
                      border: InputBorder.none, // 设置外边框为none
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 23),
                      errorText: _errPwd,
                    ),
                    controller: _pwdController,
                    onChanged: (value) {
                      setState(() {
                        _errPwd = _validatePassword(value)!;
                      });
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 10),
              child: SizedBox(
                height: 56,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(246, 247, 249, 1),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      border: InputBorder.none, // 设置外边框为none
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 23),
                      errorText: _errCpwd,
                    ),
                    controller: _cpwdController,
                    onChanged: (value) {
                      setState(() {
                        if (value != _cpwdController.text) {
                          _errCpwd = 'The two passwords are different';
                        } else {
                          _errCpwd = "";
                        }
                      });
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 90, 20, 4),
              child: RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text:
                          "By creating an account,you are confirming that you are at least 18 years old and agree to our ",
                      style: TextStyle(
                        color: Color.fromRGBO(173, 181, 189, 1),
                        fontSize: 14,
                      ),
                    ),
                    TextSpan(
                      text: "Terms of Service",
                      style: const TextStyle(
                        color: Color.fromRGBO(255, 93, 151, 1),
                        fontSize: 14,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          print("Terms of Service.");
                        },
                    ),
                    const TextSpan(
                      text: " and ",
                      style: TextStyle(
                        color: Color.fromRGBO(173, 181, 189, 1),
                        fontSize: 14,
                      ),
                    ),
                    TextSpan(
                      text: "Privacy Policy.",
                      style: const TextStyle(
                        color: Color.fromRGBO(255, 93, 151, 1),
                        fontSize: 14,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          print("Privacy Policy.");
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
                    _submitData();
                  },
                  child: const Text(
                    "Done",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
