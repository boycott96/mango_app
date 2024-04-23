import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_test/profile/contact_us.dart';
import 'package:flutter_application_test/profile/signin_screen.dart';
import 'package:flutter_application_test/profile/signup_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

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
    return const NoneSetting();
  }
}

class NoneSetting extends StatefulWidget {
  const NoneSetting({super.key});

  @override
  State<NoneSetting> createState() => _NoneSettingState();
}

// https://wp.larkdance.cn/b798404bdc934a33a58cbbc6314179df.jpg

class _NoneSettingState extends State<NoneSetting>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

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
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/none_bg.png'), // 这里替换为你的图片路径
          fit: BoxFit.cover,
        ),
      ),
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // 设置模糊程度
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.white.withOpacity(0.3),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 58),
          child: Center(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 93, 151, 1),
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: ClipPath(
                    clipper: CustomClipperClass(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 30),
                      child: Image.asset(
                        "assets/logo_white.png",
                        width: 93,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 96, 10, 10),
                  child: TextButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        Color.fromRGBO(187, 153, 255, 1),
                      ),
                      minimumSize:
                          MaterialStatePropertyAll(Size(double.infinity, 46)),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ContactUs()));
                    },
                    child: const Text(
                      "Feedback question",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        Color.fromRGBO(255, 93, 151, 1),
                      ),
                      minimumSize:
                          MaterialStatePropertyAll(Size(double.infinity, 46)),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Singup()));
                    },
                    child: const Text(
                      "Sign up",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        Color.fromRGBO(255, 146, 185, 1),
                      ),
                      minimumSize:
                          MaterialStatePropertyAll(Size(double.infinity, 46)),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Signin()));
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomClipperClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 20); // 左下角起点
    path.quadraticBezierTo(
        size.width / 4, size.height, size.width / 2, size.height); // 控制点和终点
    path.quadraticBezierTo(size.width * 3 / 4, size.height, size.width,
        size.height - 20); // 控制点和终点
    path.lineTo(size.width, 0); // 右上角
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
