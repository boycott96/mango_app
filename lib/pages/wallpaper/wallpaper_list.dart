import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_test/api/wallpaper.dart';
import 'package:flutter_application_test/pages/wallpaper/wallpaper_detail.dart';

class WallpaperList extends StatefulWidget {
  final int categoryId;
  final String name;
  const WallpaperList(
      {super.key, required this.categoryId, required this.name});

  @override
  State<WallpaperList> createState() => _WallpaperListState();
}

class _WallpaperListState extends State<WallpaperList>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final ScrollController _scrollController = ScrollController();

  int page = 1;

  List<dynamic> _wallpaperList = [];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);

    getWallpaperList(page);
    _controller = AnimationController(vsync: this);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // Reach the bottom
      setState(() {
        page = page + 1;
        getWallpaperList(page);
      });
    }
  }

  getWallpaperList(int pageNum) async {
    Response response = await WallpaperService(context)
        .wallpaperForCategory(widget.categoryId, pageNum);
    if (response.data['code'] == 0) {
      var newDataList = response.data['data'];
      setState(() {
        _wallpaperList = [..._wallpaperList, ...newDataList];
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // 每行显示的列数
                crossAxisSpacing: 10.0, // 列之间的间距
                mainAxisSpacing: 10.0, // 行之间的间距
                childAspectRatio: 0.6, // 子组件的宽高比例
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  var e = _wallpaperList[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WallpaperDetail(
                            id: e['id'],
                            list: _wallpaperList,
                            currentPage: page,
                            type: widget.categoryId.toString(),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      alignment: Alignment.bottomCenter,
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
                  );
                },
                childCount: _wallpaperList.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
