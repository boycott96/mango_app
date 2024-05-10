import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_test/api/wallpaper.dart';
import 'package:flutter_application_test/pages/wallpaper/wallpaper_detail.dart';

class WallpaperList extends StatefulWidget {
  final int categoryId;
  const WallpaperList({super.key, required this.categoryId});

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
        title: const Text("Wallpaper"),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: Wrap(
                  spacing: 10.0, // 调整子组件之间的间距
                  runSpacing: 10.0, // 调整行之间的间距
                  children: _wallpaperList
                      .map(
                        (e) => GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        WallpaperDetail(id: e['id'])));
                          },
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            height: 200,
                            width:
                                (MediaQuery.of(context).size.width - 32 - 25) *
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
          ),
        ),
      ),
    );
  }
}
