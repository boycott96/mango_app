import 'package:flutter_application_test/api/user.dart';
import 'package:flutter_application_test/components/toast_manager.dart';
import 'package:flutter_application_test/pages/profile/signin_screen.dart';
import 'package:flutter_application_test/utils/util.dart';
import 'package:toast/toast.dart';

import '/utils/validate.dart';
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

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
  String? _errCode;
  String? _errEmail;
  String? _errPwd;
  String? _errCpwd;

  bool _showPwd = true;
  bool _showCpwd = true;

  void _submitData(BuildContext context) async {
    final String invitationCode = _codeController.text;
    final String email = _emailController.text;
    final String password = _pwdController.text;
    final String confirmPwd = _cpwdController.text;
    setState(() {
      _errCode = validateRequired(invitationCode);
      _errEmail = validateEmail(email);
      _errPwd = validatePassword(password);
      if (password != confirmPwd) {
        _errCpwd = 'The two passwords are different';
      } else {
        _errCpwd;
      }
    });
    if (_errCode == '' || _errEmail == '' || _errPwd == '' || _errCpwd == '') {
      return;
    }
    Response res = await UserService(context).signUp({
      "code": invitationCode,
      "username": email,
      "password": hashPassword(password)
    });
    if (res.data['code'] == 0) {
      ToastManager.showToast("Registration success");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const SignIn()));
    } else {
      ToastManager.showToast(res.data['msg']);
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
        title: const Text("Welcome Sign up"),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(21, 72, 21, 10),
              child: SizedBox(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Invitation Code',
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(30),
                    ), // 设置外边框为none
                    contentPadding: const EdgeInsets.symmetric(horizontal: 23),
                    filled: true, // 设置为 true 表示填充背景色
                    fillColor: const Color.fromRGBO(246, 247, 249, 1),
                    errorText: _errCode,
                  ),
                  controller: _codeController,
                  onChanged: (value) {
                    setState(() {
                      _errCode = validateRequired(value);
                    });
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 10),
              child: SizedBox(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Email',
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
                    fillColor:
                        const Color.fromRGBO(246, 247, 249, 1), // 设置填充的背景色
                    errorText: _errPwd,
                    suffixIcon: IconButton(
                      icon: Icon(
                          _showPwd ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _showPwd = !_showPwd;
                        });
                      },
                    ),
                  ),
                  controller: _pwdController,
                  onChanged: (value) {
                    setState(() {
                      _errPwd = validatePassword(value);
                    });
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 10),
              child: SizedBox(
                // height: 56,
                child: TextField(
                  obscureText: _showCpwd,
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(30),
                    ), // 设置外边框为none
                    contentPadding: const EdgeInsets.symmetric(horizontal: 23),
                    errorText: _errCpwd,
                    filled: true, // 设置为 true 表示填充背景色
                    fillColor:
                        const Color.fromRGBO(246, 247, 249, 1), // 设置填充的背景色
                    suffixIcon: IconButton(
                      icon: Icon(
                          _showCpwd ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _showCpwd = !_showCpwd;
                        });
                      },
                    ),
                  ),
                  controller: _cpwdController,
                  onChanged: (value) {
                    setState(() {
                      if (value != '' && value != _pwdController.text) {
                        _errCpwd = 'The two passwords are different';
                      } else {
                        _errCpwd = null;
                      }
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
                      recognizer: TapGestureRecognizer()..onTap = () {},
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
                      recognizer: TapGestureRecognizer()..onTap = () {},
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
          ],
        ),
      ),
    );
  }
}
