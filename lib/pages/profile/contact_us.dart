import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs>
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact us"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  const Text(
                    "Please be specific when you descrube the problemor question,your feddback will deal with 1-2 working days.",
                    style: TextStyle(color: Color.fromRGBO(135, 141, 152, 1)),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 26),
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(249, 249, 249, 1),
                        borderRadius: BorderRadius.circular(30)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: const TextField(
                      maxLines: 8,
                      style: TextStyle(
                        backgroundColor: Color.fromRGBO(249, 249, 249, 1),
                      ),
                      decoration: InputDecoration(
                        hintText: 'Enter your text here...',
                        hintStyle: TextStyle(
                          color: Color.fromRGBO(135, 141, 152, 1),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  )
                ],
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
                    print("12321");
                  },
                  child: const Text(
                    "Submit",
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
