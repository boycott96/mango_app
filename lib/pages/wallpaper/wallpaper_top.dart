import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_test/api/wallpaper.dart';
import 'package:flutter_application_test/pages/wallpaper/wallpaper_detail.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WallpaperTop extends StatefulWidget {
  const WallpaperTop({super.key});

  @override
  State<WallpaperTop> createState() => _WallpaperTopState();
}

class _WallpaperTopState extends State<WallpaperTop>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  String _activeType = "Trending";
  final List<dynamic> _btn = [
    {
      "icon": "assets/icon/top_trending.svg",
      "active_icon": "assets/icon/top_trending_active.svg",
      "label": "Trending",
      "width": "22",
    },
    {
      "icon": "assets/icon/top_recent.svg",
      "active_icon": "assets/icon/top_recent_active.svg",
      "label": "Recent",
      "width": "25",
    },
    {
      "icon": "assets/icon/top_new.svg",
      "active_icon": "assets/icon/top_new_active.svg",
      "label": "New",
      "width": "25",
    },
  ];

  List<dynamic> _list = [];

  @override
  void initState() {
    super.initState();
    getList();
    _controller = AnimationController(vsync: this);
  }

  void getList() async {
    if (_activeType == 'Trending') {
      Response response = await WallpaperService(context).trending();
      if (response.data['code'] == 0) {
        setState(() {
          _list = response.data['data'];
        });
      }
    } else if (_activeType == 'Recent') {
      Response response = await WallpaperService(context).recent();
      if (response.data['code'] == 0) {
        setState(() {
          _list = response.data['data'];
        });
      }
    } else if (_activeType == 'New') {
      Response response = await WallpaperService(context).topNew();
      if (response.data['code'] == 0) {
        setState(() {
          _list = response.data['data'];
        });
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void viewWallpaper(String id) {
    // 跳转到壁纸的详情页面
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => WallpaperDetail(id: id)));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(225, 244, 255, 1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: _btn
                .map(
                  (e) => Container(
                    width: (MediaQuery.of(context).size.width - 32 - 45) * 0.33,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: _activeType == e['label']
                          ? const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color.fromRGBO(103, 71, 231, 1),
                                Color.fromRGBO(0, 255, 240, 1),
                              ],
                            )
                          : null,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _activeType = e['label'];
                          getList();
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.transparent),
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.only(top: 3, bottom: 0)),
                      ),
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            _activeType == e['label']
                                ? e['active_icon']
                                : e['icon'],
                            width: double.parse(e['width']),
                          ),
                          Text(
                            e['label'],
                            style: TextStyle(
                              color: _activeType == e['label']
                                  ? Colors.white
                                  : const Color.fromRGBO(71, 71, 227, 1),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Wrap(
                spacing: 10.0, // 调整子组件之间的间距
                runSpacing: 10.0, // 调整行之间的间距
                children: _list
                    .map(
                      (e) => GestureDetector(
                        onTap: () {
                          viewWallpaper(e['id']);
                        },
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          height: 200,
                          width: (MediaQuery.of(context).size.width - 32 - 25) *
                              0.33,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                              image: NetworkImage(e['thumbnailLarge']),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Text(
                            e['resolution'],
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            )
          ],
        )
      ],
    );
  }
}
