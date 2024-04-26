import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_test/api/token_manager.dart';
import 'package:flutter_application_test/api/user.dart';
import 'package:flutter_application_test/components/toast_manager.dart';
import 'package:flutter_application_test/pages/main_screen.dart';
import 'package:flutter_application_test/pages/profile/reset_screen.dart';
import 'package:flutter_application_test/pages/profile/signup_screen.dart';
import 'package:flutter_application_test/utils/validate.dart';

import '../../api/api.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final TextEditingController _pwdController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String _errEmail = "";
  String _errPwd = "";

  void _submitData(BuildContext context) async {
    var email = _emailController.text;
    var password = _pwdController.text;
    _errEmail = validateEmail(email);
    _errPwd = validateRequired(password);
    if (_errEmail != '' || _errPwd != '') {
      return;
    }
    if (mounted) {
      R<Token> res =
          await UserService().signIn({"email": email, "password": password});
      if (res.code == 0) {
        TokenManager.saveToken(res.data.accessToken);
        ToastManager.showToast("login sucess!");
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const MainScreen()));
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
                height: 56,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(246, 247, 249, 1),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: 'Email address',
                        errorText: _errEmail,
                        border: InputBorder.none, // 设置外边框为none
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 23)),
                    controller: _emailController,
                    onChanged: (value) {
                      setState(() {
                        _errEmail = validateEmail(value);
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
                        errorText: _errPwd,
                        border: InputBorder.none, // 设置外边框为none
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 23)),
                    controller: _pwdController,
                    onChanged: (value) {
                      setState(() {
                        _errPwd = validateRequired(value);
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
