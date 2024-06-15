import 'package:flutter/material.dart';
import 'package:flutter_application_test/pages/wallpaper/category_list.dart';
import 'package:flutter_application_test/pages/wallpaper/wallpaper_detail.dart';
import 'package:flutter_application_test/pages/wallpaper/wallpaper_new.dart';
import 'package:flutter_application_test/pages/wallpaper/wallpaper_recent.dart';
import 'package:flutter_application_test/pages/wallpaper/wallpaper_trending.dart';

class WallpaperScreen extends StatefulWidget {
  const WallpaperScreen({super.key});

  @override
  State<WallpaperScreen> createState() => _WallpaperScreenState();
}

class _WallpaperScreenState extends State<WallpaperScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  String _activeType = "最新";
  final List<dynamic> _btn = [
    {
      "label": "最新",
    },
    {
      "label": "热门",
    },
    {
      "label": "历史记录",
    },
    {
      "label": "分类",
    }
  ];

  int page = 1;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  void viewWallpaper(String id) {
    // 跳转到壁纸的详情页面
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => WallpaperDetail(id: id)));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int _getIndexFromActiveType(String activeType) {
    switch (activeType) {
      case '热门':
        return 1;
      case '最新':
        return 0;
      case '历史记录':
        return 2;
      case '分类':
        return 3;
      default:
        return 0; // Default to the first widget or handle as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IndexedStack(
          index: _getIndexFromActiveType(
              _activeType), // Determine the index based on _activeType
          children: const [
            WallpaperNew(),
            WallpaperTrending(),
            WallpaperRecent(),
            CategoryList(),
          ],
        ),
        Positioned(
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(246, 246, 246, 0.8),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: _btn
                  .map(
                    (e) => Container(
                      width: (MediaQuery.of(context).size.width - 24) * 0.25,
                      height: 35,
                      decoration: BoxDecoration(
                        color: _activeType == e['label']
                            ? const Color.fromRGBO(183, 183, 183, 1)
                            : null,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            _activeType = e['label'];
                          });
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.only(top: 5, bottom: 0)),
                        ),
                        child: Column(
                          children: [
                            Text(
                              e['label'],
                              style: TextStyle(
                                color: _activeType == e['label']
                                    ? Colors.white
                                    : const Color.fromRGBO(140, 140, 140, 1),
                                fontSize: 16,
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
        )
      ],
    );
  }
}
