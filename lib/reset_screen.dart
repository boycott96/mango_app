import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ResetPage extends StatefulWidget {
  const ResetPage({super.key});

  @override
  State<ResetPage> createState() => _RestPageState();
}

class _RestPageState extends State<ResetPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final TextEditingController _textController = TextEditingController();
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
        title: const Text("Reset Passage"),
      ),
      body: Container(
        color: const Color.fromRGBO(249, 249, 249, 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              margin: const EdgeInsets.fromLTRB(15, 20, 15, 20),
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
              child: Column(
                children: [
                  SizedBox(
                    height: 65,
                    child: Container(
                      alignment: Alignment.center,
                      child: TextField(
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 20),
                            hintText: 'Email',
                            hintStyle: TextStyle(
                                color: Color.fromRGBO(173, 181, 189, 1)),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(206, 212, 218, 0.2),
                                  width: 2.0),
                            )),
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
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 20),
                            hintText: 'Verify Code',
                            hintStyle: TextStyle(
                                color: Color.fromRGBO(173, 181, 189, 1)),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(206, 212, 218, 0.2),
                                  width: 2.0),
                            ),
                          ),
                          controller: _textController,
                          onChanged: (value) {
                            setState(() {
                              _inputValue = value;
                            });
                            print(_inputValue);
                          },
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text("Get code"),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromRGBO(233, 236, 239, 1)),
                            padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12))),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 65,
                    child: Container(
                      alignment: Alignment.center,
                      child: TextField(
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 20),
                            hintText: 'New password',
                            hintStyle: TextStyle(
                                color: Color.fromRGBO(173, 181, 189, 1)),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(206, 212, 218, 0.2),
                                  width: 2.0),
                            )),
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
                  SizedBox(
                    height: 65,
                    child: Container(
                      alignment: Alignment.center,
                      child: TextField(
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 20),
                          hintText: 'Confirm Password',
                          hintStyle: TextStyle(
                              color: Color.fromRGBO(173, 181, 189, 1)),
                          border: InputBorder.none,
                        ),
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
                ],
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 90, 20, 4),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: "Need help ? please contact us ",
                          style: TextStyle(
                            color: Color.fromRGBO(21, 30, 44, 1),
                            fontSize: 14,
                          ),
                        ),
                        TextSpan(
                          text: "contact us",
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 46,
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color?>(
                            const Color.fromRGBO(255, 93, 151, 1)),
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
          ],
        ),
      ),
    );
  }
}
