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
  final String _erroCode = "";
  final String _errEmail = "";
  final String _errPwd = "";
  final String _errCpwd = "";

  String? _validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
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
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    // 使用正则表达式检查密码格式
    final passwordRegExp = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{4,20}$');
    if (!passwordRegExp.hasMatch(value)) {
      return 'Password must contain at least one letter and one number, and be 4-20 characters long';
    }
    return null;
  }

  void _submitData() {
    final String invitationCode = _codeController.text;
    final String email = _emailController.text;
    final String password = _pwdController.text;
    final String confirmPwd = _cpwdController.text;
    var erroCode = _validateInput(invitationCode);
    var errEmail = _validateEmail(email);
    var errPwd = _validatePassword(password);

    // 在这里执行提交操作，比如发送网络请求或者保存数据到本地

    print('Invitation Code: $invitationCode');
    print('Email: $email');
    print('Password: $password');
    print('Repeat Password: $confirmPwd');

    // 这里可以添加你的提交逻辑，比如发送网络请求等
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
                    decoration: const InputDecoration(
                      hintText: 'Invitation Code',
                      border: InputBorder.none, // 设置外边框为none
                      contentPadding: EdgeInsets.symmetric(horizontal: 23),
                      errorText: "邀请码不能为空",
                    ),
                    controller: _codeController,
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
                    decoration: const InputDecoration(
                        hintText: 'Email',
                        border: InputBorder.none, // 设置外边框为none
                        contentPadding: EdgeInsets.symmetric(horizontal: 23)),
                    controller: _emailController,
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
                    decoration: const InputDecoration(
                        hintText: 'Password',
                        border: InputBorder.none, // 设置外边框为none
                        contentPadding: EdgeInsets.symmetric(horizontal: 23)),
                    controller: _pwdController,
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
                    decoration: const InputDecoration(
                        hintText: 'Confirm Password',
                        border: InputBorder.none, // 设置外边框为none
                        contentPadding: EdgeInsets.symmetric(horizontal: 23)),
                    controller: _cpwdController,
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
