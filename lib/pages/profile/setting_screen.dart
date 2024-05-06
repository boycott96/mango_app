import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

  final List<String> items = List.generate(5, (index) => 'Item $index');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 13),
        decoration: const BoxDecoration(
          color: Color.fromRGBO(249, 249, 249, 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 22),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Email",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SvgPicture.asset(
                        "assets/icon/arrow_right_thin.svg",
                        width: 20,
                        height: 20,
                        theme: const SvgTheme(
                          currentColor: Color.fromRGBO(211, 215, 222, 1),
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Color.fromRGBO(206, 212, 218, 0.2), // 可以设置颜色
                    thickness: 1, // 设置厚度
                    height: 44, // 设置高度
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Password",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SvgPicture.asset(
                        "assets/icon/arrow_right_thin.svg",
                        width: 20,
                        height: 20,
                        theme: const SvgTheme(
                          currentColor: Color.fromRGBO(211, 215, 222, 1),
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Color.fromRGBO(206, 212, 218, 0.2), // 可以设置颜色
                    thickness: 1, // 设置厚度
                    height: 44, // 设置高度
                  ),
                  GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Contact us",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SvgPicture.asset(
                          "assets/icon/arrow_right_thin.svg",
                          width: 20,
                          height: 20,
                          theme: const SvgTheme(
                            currentColor: Color.fromRGBO(211, 215, 222, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: Color.fromRGBO(206, 212, 218, 0.2), // 可以设置颜色
                    thickness: 1, // 设置厚度
                    height: 44, // 设置高度
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Privacy policy",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SvgPicture.asset(
                          "assets/icon/arrow_right_thin.svg",
                          width: 20,
                          height: 20,
                          theme: const SvgTheme(
                            currentColor: Color.fromRGBO(211, 215, 222, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(6, 8, 6, 12),
              child: SizedBox(
                width: double.infinity,
                height: 46,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color?>(
                        const Color.fromRGBO(255, 93, 151, 1)),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Sign out",
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
