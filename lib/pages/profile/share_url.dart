import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_test/api/share.dart';
import 'package:flutter_application_test/components/toast_manager.dart';
import 'package:flutter_application_test/pages/main_screen.dart';
import 'package:toast/toast.dart';

class ShareUrl extends StatefulWidget {
  final String type;
  const ShareUrl({super.key, required this.type});

  @override
  State<ShareUrl> createState() => _ShareUrlState();
}

class _ShareUrlState extends State<ShareUrl>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final TextEditingController _shareUrlController = TextEditingController();

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

  void _submitData(BuildContext context) async {
    String url = _shareUrlController.text;
    if (url != '') {
      if (widget.type == 'album') {
        Response res = await ShareService.addAlbum({"albumUrl": url});
        if (res.data['code'] == 0) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const MainScreen()));
          ToastManager.showToast("Please wait for official processing",
              duration: 5);
        } else {
          ToastManager.showToast("The playlist has been processed",
              duration: 5);
        }
      } else if (widget.type == 'song') {
        Response res = await ShareService.addSong({"linkUrl": url});
        if (res.data['code'] == 0) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const MainScreen()));
          ToastManager.showToast("Please wait for official processing",
              duration: 5);
        } else {
          ToastManager.showToast("The song has been processed", duration: 5);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Share Url"),
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
                  Container(
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(249, 249, 249, 1),
                        borderRadius: BorderRadius.circular(30)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: TextField(
                      maxLines: 8,
                      style: const TextStyle(
                        backgroundColor: Color.fromRGBO(249, 249, 249, 1),
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Please input yours share url...',
                        hintStyle: TextStyle(
                          color: Color.fromRGBO(135, 141, 152, 1),
                        ),
                        border: InputBorder.none,
                      ),
                      controller: _shareUrlController,
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
                    _submitData(context);
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
