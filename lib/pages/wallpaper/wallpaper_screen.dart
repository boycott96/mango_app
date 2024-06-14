import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_test/api/wallpaper.dart';
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
  final ScrollController _scrollController = ScrollController();

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

  List<dynamic> _list = [];

  int page = 1;

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // Reach the bottom
      setState(() {
        page = page + 1;
        getList(page);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getList(1);
    _scrollController.addListener(_scrollListener);
    _controller = AnimationController(vsync: this);
  }

  void viewWallpaper(String id) {
    // 跳转到壁纸的详情页面
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => WallpaperDetail(id: id)));
  }

  void getList(int pageNum) async {
    if (_activeType == '热门') {
      Response response = await WallpaperService(context).trending(pageNum);
      if (response.data['code'] == 0) {
        setState(() {
          _list = [..._list, ...response.data['data']];
        });
      }
    } else if (_activeType == '历史记录') {
      Response response = await WallpaperService(context).recent(pageNum);
      if (response.data['code'] == 0) {
        setState(() {
          _list = [..._list, ...response.data['data']];
        });
      }
    } else if (_activeType == '最新') {
      Response response = await WallpaperService(context).topNew(pageNum);
      if (response.data['code'] == 0) {
        setState(() {
          _list = [..._list, ...response.data['data']];
        });
      }
    }
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
