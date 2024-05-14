import 'package:flutter/material.dart';

class MusicScreen extends StatefulWidget {
  const MusicScreen({super.key});

  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen>
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
      color: const Color.fromRGBO(237, 241, 244, 0.6),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Made for you",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 56,
              child: TextButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    const Text(
                      "Import a certain Q music playlist link",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    const Color.fromRGBO(77, 25, 225, 1),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    "https://wp.larkdance.cn/file/category/Anime & Manga.jpg",
                    width: 68,
                    height: 68,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: 68,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 4),
                        child: Text(
                          "冷冷的外星人喜欢的音乐",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "103首",
                            style: TextStyle(
                              color: Color.fromRGBO(53, 55, 59, 1),
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            "失去才懂（纯音乐）-木则",
                            style: TextStyle(
                              color: Color.fromRGBO(53, 55, 59, 1),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
