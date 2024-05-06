import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_test/pages/profile/edit_profile.dart';
import 'package:flutter_application_test/pages/profile/me_screen.dart';
import 'package:flutter_application_test/pages/profile/setting_screen.dart';
import 'package:flutter_application_test/pages/profile/share_url.dart';
import 'package:flutter_svg/svg.dart';

class ProfileData extends StatefulWidget {
  final Map<String, dynamic> profile;

  const ProfileData({super.key, required this.profile});

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
                    Padding(
                        padding: const EdgeInsets.only(top: 30, bottom: 7),
                        child: SvgPicture.asset(
                          "assets/icon/crown.svg",
                        )),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image.asset(
                        "assets/default_avatar.jpg",
                        width: 110,
                        height: 110,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 4),
                      child: Text(
                        widget.profile['username'],
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // 子组件在交叉轴上向左对齐
                      mainAxisAlignment:
                          MainAxisAlignment.center, // 子组件在主轴上居中排列
                      children: [
                        SvgPicture.asset(
                          "assets/icon/location_2.svg",
                          width: 16,
                          height: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, bottom: 30),
                          child: Column(
                            children: [
                              Text(widget.profile['location']),
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
            child: Stack(
              clipBehavior: Clip.none, // 禁用Stack的裁剪行为
              children: [
                Container(
                  color: const Color.fromRGBO(249, 249, 249, 1),
                  padding: const EdgeInsets.fromLTRB(15, 62, 15, 0),
                  constraints: const BoxConstraints.expand(), // 设置宽度充满
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const EditProfile()));
                          },
                          child: Container(
                            height:
                                (MediaQuery.of(context).size.width - 60) * 0.33,
                            width:
                                (MediaQuery.of(context).size.width - 60) * 0.33,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromRGBO(255, 228, 238, 1),
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: SvgPicture.asset(
                                    "assets/icon/profile.svg",
                                    width: 25,
                                    height: 25,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 6),
                                  child: Text(
                                    "My profile",
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
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (contxt) =>
                                      const ShareUrl(type: "album")),
                            );
                          },
                          child: Container(
                            height:
                                (MediaQuery.of(context).size.width - 60) * 0.33,
                            width:
                                (MediaQuery.of(context).size.width - 60) * 0.33,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromRGBO(228, 250, 255, 1),
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: SvgPicture.asset(
                                    "assets/icon/album.svg",
                                    width: 25,
                                    height: 25,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 6),
                                  child: Text(
                                    "Song list",
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
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SettingScreen()));
                          },
                          child: Container(
                            height:
                                (MediaQuery.of(context).size.width - 60) * 0.33,
                            width:
                                (MediaQuery.of(context).size.width - 60) * 0.33,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromRGBO(237, 228, 255, 1),
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: SvgPicture.asset(
                                    "assets/icon/setting.svg",
                                    width: 25,
                                    height: 25,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 6),
                                  child: Text(
                                    "Settings",
                                    style: TextStyle(
                                      color: Color.fromRGBO(34, 34, 34, 1),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: -30,
                  left: 20,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      height: 60,
                      width: MediaQuery.of(context).size.width - 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        image: const DecorationImage(
                          image: AssetImage("assets/inv_code.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: SvgPicture.asset(
                              "assets/icon/inv_code.svg",
                              width: 25,
                              height: 25,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 9),
                            child: const Text(
                              "Inv. Code",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Expanded(child: Container()),
                          Container(
                            margin: const EdgeInsets.only(right: 15),
                            child: SvgPicture.asset(
                              "assets/icon/arrow_right.svg",
                              width: 22,
                              height: 22,
                              theme: const SvgTheme(currentColor: Colors.white),
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
        ],
      ),
    );
  }
}
