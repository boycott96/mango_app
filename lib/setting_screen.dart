import 'package:flutter/material.dart';
import 'package:flutter_application_test/signup_screen.dart';

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
    return Container(
      color: const Color.fromARGB(255, 245, 245, 245),
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          Row(
            children: [
              Card(
                elevation: 4,
                color: Colors.white,
                margin: const EdgeInsets.all(20),
                borderOnForeground: true,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 12.0),
                      child: ClipOval(
                        child: Image.network(
                          fit: BoxFit.fill,
                          "https://wp.larkdance.cn/b798404bdc934a33a58cbbc6314179df.jpg",
                          height: 56,
                          width: 56,
                        ),
                      ),
                    ),
                    const Text(
                      "Wendux",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              OutlinedButton(
                onPressed: () {
                  print("object");
                },
                child: const Text("登陆"),
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const SignUp()));
                },
                child: const Text("注册"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
