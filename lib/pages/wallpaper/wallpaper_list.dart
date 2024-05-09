import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_test/api/wallpaper.dart';

class WallpaperList extends StatefulWidget {
  final int categoryId;
  const WallpaperList({super.key, required this.categoryId});

  @override
  State<WallpaperList> createState() => _WallpaperListState();
}

class _WallpaperListState extends State<WallpaperList>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int page = 1;

  @override
  void initState() {
    super.initState();
    getWallpaperList();
    _controller = AnimationController(vsync: this);
  }
  
  getWallpaperList() async{
    Response response  = await WallpaperService(context).wallpaperForCategory(widget.categoryId, page);
    if (response.data['code'] == 0) {
      print(response.data['data']);
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
      body: Text("${widget.categoryId}")
    );
  }
}