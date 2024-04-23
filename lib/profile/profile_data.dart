import 'package:flutter/material.dart';
import 'package:flutter_application_test/profile/share_url.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class ProfileData extends StatefulWidget {
  const ProfileData({super.key});

  @override
  State<ProfileData> createState() => _ProfileDataState();
}

class _ProfileDataState extends State<ProfileData>
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
      alignment: Alignment.center,
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              constraints: const BoxConstraints.expand(), // 设置宽度充满
              child: Center(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 30, bottom: 7),
                      child: Image(
                        image: Svg('assets/icon/crown.svg'), // SVG文件的路径
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image.asset(
                        "assets/default_avatar.jpg",
                        width: 110,
                        height: 110,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 8, bottom: 4),
                      child: Text(
                        "Anne Hathaway",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // 子组件在交叉轴上向左对齐
                      mainAxisAlignment:
                          MainAxisAlignment.center, // 子组件在主轴上居中排列
                      children: [
                        Image(
                          image: Svg('assets/icon/location.svg'), // SVG文件的路径
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 30, right: 30),
                          child: Column(
                            children: [
                              Text("New York State"),
                              Text("Brooklyn")
                            ],
                          ),
                        )
                      ],
                    ),
                    const Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // 子组件在交叉轴上向左对齐
                      mainAxisAlignment:
                          MainAxisAlignment.center, // 子组件在主轴上居中排列
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                          child: Column(
                            children: [
                              Text(
                                "13",
                                style: TextStyle(
                                  color: Color.fromRGBO(34, 34, 34, 1),
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Likes List",
                                style: TextStyle(
                                  color: Color.fromRGBO(34, 34, 34, 1),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                          child: Column(
                            children: [
                              Text(
                                "9",
                                style: TextStyle(
                                  color: Color.fromRGBO(34, 34, 34, 1),
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Last week",
                                style: TextStyle(
                                  color: Color.fromRGBO(34, 34, 34, 1),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                          child: Column(
                            children: [
                              Text(
                                "95",
                                style: TextStyle(
                                  color: Color.fromRGBO(34, 34, 34, 1),
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Total dur",
                                style: TextStyle(
                                  color: Color.fromRGBO(34, 34, 34, 1),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: const Color.fromRGBO(249, 249, 249, 1),
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 62),
              constraints: const BoxConstraints.expand(), // 设置宽度充满
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 11),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (contxt) => const ShareUrl()),
                        );
                      },
                      child: Container(
                        height: 108,
                        width: 108,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: Svg("assets/icon/album.svg"),
                              width: 40,
                              height: 40,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 6),
                              child: Text(
                                "Album url",
                                style: TextStyle(
                                  color: Color.fromRGBO(34, 34, 34, 1),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 11),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (contxt) => const ShareUrl()),
                        );
                      },
                      child: Container(
                        height: 108,
                        width: 108,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: Svg("assets/icon/music.svg"),
                              width: 40,
                              height: 40,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 6),
                              child: Text(
                                "Song url",
                                style: TextStyle(
                                  color: Color.fromRGBO(34, 34, 34, 1),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
