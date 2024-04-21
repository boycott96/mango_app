import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with SingleTickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  late AnimationController _controller;
  String _inputValue = '';

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
                    color: const Color.fromARGB(255, 246, 247, 249),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: TextField(
                    decoration: const InputDecoration(
                        hintText: 'Invitation Code',
                        border: InputBorder.none, // 设置外边框为none
                        contentPadding: EdgeInsets.symmetric(horizontal: 23)),
                    controller: _textController,
                    onChanged: (value) {
                      setState(() {
                        _inputValue = value;
                      });
                      print(_inputValue);
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
                    color: const Color.fromARGB(255, 246, 247, 249),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: TextField(
                    decoration: const InputDecoration(
                        hintText: 'Email',
                        border: InputBorder.none, // 设置外边框为none
                        contentPadding: EdgeInsets.symmetric(horizontal: 23)),
                    controller: _textController,
                    onChanged: (value) {
                      setState(() {
                        _inputValue = value;
                      });
                      print(_inputValue);
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
                    color: const Color.fromARGB(255, 246, 247, 249),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: TextField(
                    decoration: const InputDecoration(
                        hintText: 'Password',
                        border: InputBorder.none, // 设置外边框为none
                        contentPadding: EdgeInsets.symmetric(horizontal: 23)),
                    controller: _textController,
                    onChanged: (value) {
                      setState(() {
                        _inputValue = value;
                      });
                      print(_inputValue);
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
                    color: const Color.fromARGB(255, 246, 247, 249),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: TextField(
                    decoration: const InputDecoration(
                        hintText: 'Repet Password',
                        border: InputBorder.none, // 设置外边框为none
                        contentPadding: EdgeInsets.symmetric(horizontal: 23)),
                    controller: _textController,
                    onChanged: (value) {
                      setState(() {
                        _inputValue = value;
                      });
                      print(_inputValue);
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
                        color: Color.fromARGB(255, 173, 181, 189),
                        fontSize: 14,
                      ),
                    ),
                    TextSpan(
                      text: "Terms of Service",
                      style: const TextStyle(
                        color: Color.fromARGB(255, 255, 93, 151),
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
                        color: Color.fromARGB(255, 173, 181, 189),
                        fontSize: 14,
                      ),
                    ),
                    TextSpan(
                      text: "Privacy Policy.",
                      style: const TextStyle(
                        color: Color.fromARGB(255, 255, 93, 151),
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
                        const Color.fromARGB(255, 255, 93, 151)),
                  ),
                  onPressed: () {
                    print("12321");
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
