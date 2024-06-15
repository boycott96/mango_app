import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_test/api/wallpaper.dart';
import 'package:flutter_application_test/pages/wallpaper/wallpaper_detail.dart';

class WallpaperNew extends StatefulWidget {
  const WallpaperNew({super.key});

  @override
  State<WallpaperNew> createState() => _WallpaperNewState();
}

class _WallpaperNewState extends State<WallpaperNew>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final ScrollController _scrollController = ScrollController();
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
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WallpaperDetail(
          id: id,
          list: _list,
          currentPage: page,
          type: "new",
        ),
      ),
    );
  }

  void getList(int pageNum) async {
    Response response = await WallpaperService(context).topNew(pageNum);
    if (response.data['code'] == 0) {
      setState(() {
        _list = [..._list, ...response.data['data']];
      });
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
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
          sliver: SliverList(
            delegate: SliverChildListDelegate(
              [
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
                                  height: (MediaQuery.of(context).size.width) *
                                      0.33,
                                  width: (MediaQuery.of(context).size.width) *
                                      0.33,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(e['thumbnailSmall']),
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
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
