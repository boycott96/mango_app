import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_test/api/wallpaper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';

class WallpaperDetail extends StatefulWidget {
  final String id;
  const WallpaperDetail({super.key, required this.id});

  @override
  State<WallpaperDetail> createState() => _WallpaperDetailState();
}

class _WallpaperDetailState extends State<WallpaperDetail>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  dynamic wallpaper;

  @override
  void initState() {
    super.initState();
    getInfo();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose(); //super.dispose();
  }

  String formatBytes(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    } else if (bytes < 1024 * 1024) {
      double kb = bytes / 1024;
      return '${kb.toStringAsFixed(2)} KB';
    } else if (bytes < 1024 * 1024 * 1024) {
      double mb = bytes / (1024 * 1024);
      return '${mb.toStringAsFixed(2)} MB';
    } else {
      double gb = bytes / (1024 * 1024 * 1024);
      return '${gb.toStringAsFixed(2)} GB';
    }
  }

  void getInfo() async {
    Response response = await WallpaperService.info(widget.id);
    if (response.data['code'] == 0) {
      setState(() {
        wallpaper = response.data['data'];
      });
    }
  }

  void _onShareWithResult(BuildContext context) async {
    // A builder is used to retrieve the context immediately
    // surrounding the ElevatedButton.
    //
    // The context's `findRenderObject` returns the first
    // RenderObject in its descendent tree when it's not
    // a RenderObjectWidget. The ElevatedButton's RenderObject
    // has its position and size after it's built.
    final box = context.findRenderObject() as RenderBox?;

    final scaffoldMessenger = ScaffoldMessenger.of(context);
    ShareResult shareResult;
    shareResult = await Share.share(
      wallpaper['path'],
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
    scaffoldMessenger.showSnackBar(getResultSnackBar(shareResult));
  }

  SnackBar getResultSnackBar(ShareResult result) {
    return SnackBar(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Share result: ${result.status}"),
          if (result.status == ShareResultStatus.success)
            Text("Shared to: ${result.raw}")
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 检查数据是否加载完成，若未加载完成，则显示一个加载中的指示器
    return Scaffold(
      appBar: AppBar(),
      body: wallpaper == null
          ? const Center(
              child: SizedBox(
                width: 40, // 设置加载圈的宽度
                height: 40, // 设置加载圈的高度
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(wallpaper['path']),
                  fit: BoxFit.cover,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // 设置模糊半径
                child: Container(
                  padding: const EdgeInsets.fromLTRB(50, 20, 50, 10),
                  color: Colors.white.withOpacity(0.4), // 设置模糊层的颜色和透明度
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(wallpaper['path']),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(16)),
                          child: Column(
                            children: [
                              Expanded(child: Container()),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center, // 设置子组件在纵轴方向居中对齐
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            // 按钮点击事件
                                            _onShareWithResult(context);
                                          },
                                          child: Container(
                                            width: 32, // 设置按钮宽度
                                            height: 32, // 设置按钮高度
                                            decoration: const BoxDecoration(
                                              shape: BoxShape
                                                  .circle, // 将 Container 设置为圆形
                                              color: Color.fromRGBO(
                                                  25, 30, 49, 0.53), // 设置按钮颜色
                                            ),
                                            child: Center(
                                              child: SvgPicture.asset(
                                                "assets/icon/share.svg",
                                                width: 18,
                                                theme: const SvgTheme(
                                                    currentColor: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(top: 8),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: const Color.fromRGBO(
                                                25, 30, 49, 0.7),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: const Text(
                                            "Sha.",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 16),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center, // 设置子组件在纵轴方向居中对齐
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            // 按钮点击事件
                                          },
                                          child: Container(
                                            width: 32, // 设置按钮宽度
                                            height: 32, // 设置按钮高度
                                            decoration: const BoxDecoration(
                                              shape: BoxShape
                                                  .circle, // 将 Container 设置为圆形
                                              color: Color.fromRGBO(
                                                  25, 30, 49, 0.53), // 设置按钮颜色
                                            ),
                                            child: Center(
                                              child: SvgPicture.asset(
                                                "assets/icon/brush.svg",
                                                width: 18,
                                                theme: const SvgTheme(
                                                    currentColor: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(top: 8),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: const Color.fromRGBO(
                                                25, 30, 49, 0.7),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: const Text(
                                            "Set.",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center, // 设置子组件在纵轴方向居中对齐
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            // 按钮点击事件
                                          },
                                          child: Container(
                                            width: 32, // 设置按钮宽度
                                            height: 32, // 设置按钮高度
                                            decoration: const BoxDecoration(
                                              shape: BoxShape
                                                  .circle, // 将 Container 设置为圆形
                                              color: Color.fromRGBO(
                                                  25, 30, 49, 0.53), // 设置按钮颜色
                                            ),
                                            child: Center(
                                              child: SvgPicture.asset(
                                                "assets/icon/heart.svg",
                                                width: 18,
                                                theme: const SvgTheme(
                                                    currentColor: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(top: 8),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: const Color.fromRGBO(
                                                25, 30, 49, 0.7),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: const Text(
                                            "Fav.",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "R:${wallpaper['resolution']}",
                              style: const TextStyle(color: Colors.white),
                            ),
                            Text(
                              "Size:${formatBytes(wallpaper['fileSize'])}",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
