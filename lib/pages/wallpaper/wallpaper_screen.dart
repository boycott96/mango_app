import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_test/api/wallpaper.dart';
import 'package:flutter_application_test/pages/wallpaper/category_view.dart';
import 'package:flutter_application_test/pages/wallpaper/wallpaper_detail.dart';
import 'package:flutter_svg/svg.dart';

import 'carousel_hot.dart';

class WallpaperScreen extends StatefulWidget {
  const WallpaperScreen({super.key});

  @override
  State<WallpaperScreen> createState() => _WallpaperScreenState();
}

class _WallpaperScreenState extends State<WallpaperScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final ScrollController _scrollController = ScrollController();

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
    if (_activeType == 'Trending') {
      Response response = await WallpaperService(context).trending(pageNum);
      if (response.data['code'] == 0) {
        setState(() {
          _list = [..._list, ...response.data['data']];
        });
      }
    } else if (_activeType == 'Recent') {
      Response response = await WallpaperService(context).recent(pageNum);
      if (response.data['code'] == 0) {
        setState(() {
          _list = [..._list, ...response.data['data']];
        });
      }
    } else if (_activeType == 'New') {
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

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        const SliverPadding(
          padding: EdgeInsets.fromLTRB(20, 16, 20, 0),
          sliver: SliverToBoxAdapter(
            child: Column(
              children: [
                CarouselHot(),
                CategoryView(),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
          sliver: SliverList(
            delegate: SliverChildListDelegate(
              [
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      margin: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 12),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(225, 244, 255, 1),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: _btn
                            .map(
                              (e) => Container(
                                width: (MediaQuery.of(context).size.width -
                                        32 -
                                        45) *
                                    0.33,
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
                                      page = 1;
                                      _list = [];
                                      getList(page);
                                    });
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                    overlayColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                    padding: MaterialStateProperty.all(
                                        const EdgeInsets.only(
                                            top: 3, bottom: 0)),
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
                                              : const Color.fromRGBO(
                                                  71, 71, 227, 1),
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
                            spacing: 1.0, // 调整子组件之间的间距
                            runSpacing: 1.0, // 调整行之间的间距
                            children: _list
                                .map(
                                  (e) => GestureDetector(
                                    onTap: () {
                                      viewWallpaper(e['id']);
                                    },
                                    child: Container(
                                      alignment: Alignment.bottomCenter,
                                      height:
                                          (MediaQuery.of(context).size.width -
                                                  32 -
                                                  8) *
                                              0.33,
                                      width:
                                          (MediaQuery.of(context).size.width -
                                                  32 -
                                                  8) *
                                              0.33,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image:
                                              NetworkImage(e['thumbnailLarge']),
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
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
