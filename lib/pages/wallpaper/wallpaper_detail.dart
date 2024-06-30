import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_test/components/toast_manager.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:share_plus/share_plus.dart';
import 'package:toast/toast.dart';

class WallpaperDetail extends StatefulWidget {
  final String id;
  final List<dynamic> list;
  final int currentPage;
  final String type;
  const WallpaperDetail(
      {super.key,
      required this.id,
      required this.list,
      required this.currentPage,
      required this.type});

  @override
  State<WallpaperDetail> createState() => _WallpaperDetailState();
}

class _WallpaperDetailState extends State<WallpaperDetail>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  // ignore: unused_field
  String _platformVersion = 'Unknown';
  // ignore: unused_field
  String __heightWidth = "Unknown";
  late final PageController _pageController = PageController();
  late ScrollController _listViewController = ScrollController();
  dynamic wallpaper;
  late int _selectedIndex;
  final Map<String, File> _imageCache = {}; // 内存缓存
  bool isZooming = false;
  int _pointerCount = 0;
  bool isNormalSlide = true;

  void _onPointerDown(PointerEvent event) {
    setState(() {
      _pointerCount++;
    });
  }

  void _onPointerUp(PointerEvent event) {
    setState(() {
      _pointerCount--;
    });
  }

  @override
  void initState() {
    super.initState();
    _listViewController = ScrollController();
    initAppState();
    locateWallpaper(context, widget.id);
    _controller = AnimationController(vsync: this);
  }

  void locateWallpaper(BuildContext context, String id) async {
    for (int i = 0; i < widget.list.length; i++) {
      var wall = widget.list[i];
      if (wall['id'] == id) {
        setState(() {
          _selectedIndex = i;
          wallpaper = widget.list[_selectedIndex];
        });
        // Use addPostFrameCallback to ensure the controller is attached
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          scrollToCenter(context, _selectedIndex);
          isNormalSlide = false;
          await _pageController.animateToPage(
            i,
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
          );
          isNormalSlide = true;
        });

        break;
      }
    }
  }

  void scrollToCenter(BuildContext context, int index) {
    // 每个缩略图的宽度和它的Padding
    double itemWidth = 30.0; // 宽度
    double padding = 1.0; // 左右两侧的Padding

    // 计算滚动到中心位置的偏移量
    double offset = (index * (itemWidth + 2 * padding)) + (itemWidth / 2);
    // 滚动到计算出的偏移位置
    _listViewController.animateTo(
      offset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _listViewController.dispose();
    _controller.dispose(); //super.dispose();
  }

  void downloadAndSaveImage(String imageUrl) async {
    // 弹出确认对话框
    bool? downloadConfirmed = await showModalBottomSheet<bool>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                child: Container(
                  height: 5,
                  width: 98,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(179, 179, 179, 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 18, left: 20, right: 20),
                child: const Center(
                  child: Text(
                    "Do you want to download this image to your phone? ",
                    style: TextStyle(
                      color: Color.fromRGBO(41, 50, 59, 1),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 48, 20, 0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true); // 关闭底部对话框
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        const Color.fromRGBO(255, 93, 151, 1),
                      ),
                    ),
                    child: const Text(
                      "Confirm",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false); // 关闭底部对话框
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Color.fromRGBO(255, 93, 151, 1)),
                ),
              ),
            ],
          ),
        );
      },
    );

    if (downloadConfirmed == true) {
      try {
        // 使用Dio下载图片
        Response response = await Dio()
            .get(imageUrl, options: Options(responseType: ResponseType.bytes));
        Uint8List imageData = Uint8List.fromList(response.data);

        // 保存图片到相册
        final result = await ImageGallerySaver.saveImage(imageData);
        if (result['isSuccess']) {
          ToastManager.showToast("Image saved to gallery!");
        } else {
          ToastManager.showToast(
              "Failed to save image to gallery: ${result['error']}");
        }
        // ignore: empty_catches
      } catch (e) {}
    }
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initAppState() async {
    if (Platform.isAndroid) {
      String platformVersion;
      // ignore: no_leading_underscores_for_local_identifiers
      String _heightWidth;
      // Platform messages may fail, so we use a try/catch PlatformException.
      // We also handle the message potentially returning null.
      try {
        platformVersion = await WallpaperManager.platformVersion ??
            'Unknown platform version';
      } on PlatformException {
        platformVersion = 'Failed to get platform version.';
      }

      try {
        int height = await WallpaperManager.getDesiredMinimumHeight();
        int width = await WallpaperManager.getDesiredMinimumWidth();
        _heightWidth = "Width = $width Height = $height";
      } on PlatformException {
        platformVersion = 'Failed to get platform version.';
        _heightWidth = "Failed to get Height and Width";
      }

      // If the widget was removed from the tree while the asynchronous platform
      // message was in flight, we want to discard the reply rather than calling
      // setState to update our non-existent appearance.
      if (!mounted) return;

      setState(() {
        __heightWidth = _heightWidth;
        _platformVersion = platformVersion;
      });
    }
  }

  Future<void> setWallpaper(String url) async {
    try {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(28),
                topRight: Radius.circular(28),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: Container(
                    height: 5,
                    width: 98,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(179, 179, 179, 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 18),
                  child: const Center(
                    child: Text(
                      "What would you like to do?",
                      style: TextStyle(
                        color: Color.fromRGBO(41, 50, 59, 1),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: const Color.fromRGBO(217, 217, 217, 1),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(15)),
                    child: Wrap(
                      children: <Widget>[
                        ListTile(
                          onTap: () {
                            _setWallpaper(url, WallpaperManager.HOME_SCREEN);
                            // Navigator.of(context).pop(); // 关闭底部对话框
                          },
                          title: Row(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 8, right: 12),
                                child: SvgPicture.asset(
                                  "assets/icon/set_home.svg",
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                              const Text('Set on home screen')
                            ],
                          ),
                        ),
                        const Divider(
                          color: Color.fromRGBO(217, 217, 217, 1),
                          height: 1,
                        ),
                        ListTile(
                          onTap: () async {
                            await _setWallpaper(
                                url, WallpaperManager.LOCK_SCREEN);
                            Navigator.of(context).pop(); // 关闭底部对话框
                          },
                          title: Row(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 8, right: 12),
                                child: SvgPicture.asset(
                                  "assets/icon/set_lock.svg",
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                              const Text('Set on lock screen')
                            ],
                          ),
                        ),
                        const Divider(
                          color: Color.fromRGBO(217, 217, 217, 1),
                          height: 1,
                        ),
                        ListTile(
                          onTap: () async {
                            await _setWallpaper(
                                url, WallpaperManager.BOTH_SCREEN);
                            Navigator.of(context).pop(); // 关闭底部对话框
                          },
                          title: Row(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 8, right: 12),
                                child: SvgPicture.asset(
                                  "assets/icon/set_both.svg",
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                              const Text('Set on both screen')
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // 关闭底部对话框
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        const Color.fromRGBO(25, 30, 49, 1),
                      ),
                    ),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    } on PlatformException {}
  }

  Future<void> _setWallpaper(String url, int location) async {
    // 获取屏幕尺寸
    final Size screenSize = MediaQuery.of(context).size;
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: (await _getLocalFile(url)).path,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      aspectRatio:
          CropAspectRatio(ratioX: screenSize.width, ratioY: screenSize.height),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Setting Wallpaper',
          toolbarColor: const Color.fromRGBO(20, 20, 20, 1),
          toolbarWidgetColor: Colors.white,
          backgroundColor: const Color.fromRGBO(20, 20, 20, 1),
          initAspectRatio: CropAspectRatioPreset.original,
          dimmedLayerColor: const Color.fromRGBO(20, 20, 20, 1),
          hideBottomControls: true,
          showCropGrid: false,
          lockAspectRatio: true,
        ),
        IOSUiSettings(
          title: 'Setting Wallpaper',
        ),
        WebUiSettings(
          context: context,
          presentStyle: CropperPresentStyle.dialog,
          boundary: const CroppieBoundary(
            width: 520,
            height: 520,
          ),
          viewPort:
              const CroppieViewPort(width: 480, height: 480, type: 'circle'),
          enableExif: true,
          enableZoom: false,
          showZoomer: false,
        ),
      ],
    );
    WallpaperManager.setWallpaperFromFile(croppedFile!.path, location);
    Navigator.of(context).pop(); // 关闭底部对话框
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

  Future<File> _getLocalFile(String url) async {
    if (_imageCache.containsKey(url)) {
      return _imageCache[url]!;
    }

    var cacheManager = DefaultCacheManager();
    var fileInfo = await cacheManager.getFileFromCache(url);
    if (fileInfo != null) {
      _imageCache[url] = fileInfo.file;
      return fileInfo.file;
    } else {
      var file = await cacheManager.getSingleFile(url);
      _imageCache[url] = file;
      return file;
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
    ToastContext().init(context);
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
          : SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Container(
                  color: Colors.white.withOpacity(0.4), // 设置模糊层的颜色和透明度
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          // Expanded(
                          //   child: Container(
                          //     decoration: BoxDecoration(
                          //         image: DecorationImage(
                          //           image: FileImage(_file),
                          //           fit: BoxFit.contain,
                          //         ),
                          //         borderRadius: BorderRadius.circular(16)),
                          //     child: Column(
                          //       children: [
                          //         Expanded(child: Container()),
                          //         Row(
                          //           mainAxisAlignment: MainAxisAlignment.center,
                          //           children: [
                          //             GestureDetector(
                          //               onTap: () {
                          //                 _onShareWithResult(context);
                          //               },
                          //               child: Container(
                          //                 padding: const EdgeInsets.symmetric(
                          //                     vertical: 16),
                          //                 child: Column(
                          //                   crossAxisAlignment: CrossAxisAlignment
                          //                       .center, // 设置子组件在纵轴方向居中对齐
                          //                   children: [
                          //                     Container(
                          //                       width: 48, // 设置按钮宽度
                          //                       height: 48, // 设置按钮高度
                          //                       decoration: const BoxDecoration(
                          //                         shape: BoxShape
                          //                             .circle, // 将 Container 设置为圆形
                          //                         color: Color.fromRGBO(
                          //                             25, 30, 49, 0.53), // 设置按钮颜色
                          //                       ),
                          //                       child: Center(
                          //                         child: SvgPicture.asset(
                          //                           "assets/icon/share.svg",
                          //                           width: 24,
                          //                           theme: const SvgTheme(
                          //                               currentColor: Colors.white),
                          //                         ),
                          //                       ),
                          //                     ),
                          //                     Container(
                          //                       margin:
                          //                           const EdgeInsets.only(top: 8),
                          //                       padding: const EdgeInsets.symmetric(
                          //                           horizontal: 16, vertical: 2),
                          //                       decoration: BoxDecoration(
                          //                         color: const Color.fromRGBO(
                          //                             25, 30, 49, 0.7),
                          //                         borderRadius:
                          //                             BorderRadius.circular(12),
                          //                       ),
                          //                       child: const Text(
                          //                         "分享",
                          //                         style: TextStyle(
                          //                             color: Colors.white,
                          //                             fontSize: 12),
                          //                       ),
                          //                     ),
                          //                   ],
                          //                 ),
                          //               ),
                          //             ),
                          //             GestureDetector(
                          //               onTap: () {
                          //                 if (Platform.isIOS) {
                          //                   downloadAndSaveImage(wallpaper['path']);
                          //                 } else {
                          //                   setWallpaper(wallpaper['path']);
                          //                 }
                          //               },
                          //               child: Container(
                          //                 padding: const EdgeInsets.symmetric(
                          //                     horizontal: 8, vertical: 16),
                          //                 child: Column(
                          //                   crossAxisAlignment: CrossAxisAlignment
                          //                       .center, // 设置子组件在纵轴方向居中对齐
                          //                   children: [
                          //                     Container(
                          //                       width: 48, // 设置按钮宽度
                          //                       height: 48, // 设置按钮高度
                          //                       decoration: const BoxDecoration(
                          //                         shape: BoxShape
                          //                             .circle, // 将 Container 设置为圆形
                          //                         color: Color.fromRGBO(
                          //                             25, 30, 49, 0.53), // 设置按钮颜色
                          //                       ),
                          //                       child: Center(
                          //                         child: Platform.isAndroid
                          //                             ? SvgPicture.asset(
                          //                                 "assets/icon/brush.svg",
                          //                                 width: 24,
                          //                                 theme: const SvgTheme(
                          //                                     currentColor:
                          //                                         Colors.white),
                          //                               )
                          //                             : SvgPicture.asset(
                          //                                 "assets/icon/download.svg",
                          //                                 width: 24,
                          //                                 theme: const SvgTheme(
                          //                                     currentColor:
                          //                                         Colors.white),
                          //                               ),
                          //                       ),
                          //                     ),
                          //                     Container(
                          //                       margin:
                          //                           const EdgeInsets.only(top: 8),
                          //                       padding: const EdgeInsets.symmetric(
                          //                           horizontal: 16, vertical: 2),
                          //                       decoration: BoxDecoration(
                          //                         color: const Color.fromRGBO(
                          //                             25, 30, 49, 0.7),
                          //                         borderRadius:
                          //                             BorderRadius.circular(12),
                          //                       ),
                          //                       child: Platform.isAndroid
                          //                           ? const Text(
                          //                               "设定",
                          //                               style: TextStyle(
                          //                                 color: Colors.white,
                          //                                 fontSize: 12,
                          //                               ),
                          //                             )
                          //                           : const Text(
                          //                               "Dow.",
                          //                               style: TextStyle(
                          //                                 color: Colors.white,
                          //                                 fontSize: 12,
                          //                               ),
                          //                             ),
                          //                     ),
                          //                   ],
                          //                 ),
                          //               ),
                          //             ),
                          //           ],
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          Expanded(
                            child: Listener(
                              onPointerDown: _onPointerDown,
                              onPointerUp: _onPointerUp,
                              child: GestureDetector(
                                child: PageView.builder(
                                  controller: _pageController,
                                  itemCount: widget.list.length,
                                  itemBuilder: (context, index) {
                                    if (index == _selectedIndex) {
                                      return InteractiveViewer(
                                        panEnabled: true,
                                        minScale: 1,
                                        maxScale: 10,
                                        child: FutureBuilder<File>(
                                          future: _getLocalFile(
                                              widget.list[index]['path']!),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              if (_imageCache.containsKey(widget
                                                  .list[index]['path']!)) {
                                                return Image.file(
                                                  _imageCache[widget.list[index]
                                                      ['path']!]!,
                                                  fit: BoxFit.contain,
                                                );
                                              } else {
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              }
                                            } else if (snapshot.hasError) {
                                              return const Center(
                                                child: Icon(Icons.error),
                                              );
                                            } else if (snapshot.hasData) {
                                              return Image.file(
                                                snapshot.data!,
                                                fit: BoxFit.contain,
                                              );
                                            } else {
                                              return Container();
                                            }
                                          },
                                        ),
                                      );
                                    } else {
                                      return Container();
                                    }
                                  },
                                  onPageChanged: (int index) {
                                    if (isNormalSlide) {
                                      setState(() {
                                        wallpaper = widget.list[index];
                                        _selectedIndex = index;
                                      });
                                      scrollToCenter(context, index);
                                    }
                                  },
                                  physics: _pointerCount >= 2
                                      ? const NeverScrollableScrollPhysics()
                                      : null,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 60,
                            child: ListView(
                              controller: _listViewController,
                              scrollDirection: Axis.horizontal,
                              children: [
                                SizedBox(
                                    width: MediaQuery.of(context).size.width /
                                        2), // 手动添加的第一个项
                                ...List.generate(
                                  widget.list.length,
                                  (index) {
                                    return GestureDetector(
                                      onTap: () async {
                                        setState(() {
                                          wallpaper = widget.list[index];
                                          _selectedIndex = index;
                                        });
                                        scrollToCenter(context, index);
                                        isNormalSlide = false;
                                        await _pageController.animateToPage(
                                          index,
                                          duration:
                                              const Duration(milliseconds: 500),
                                          curve: Curves.ease,
                                        );
                                        isNormalSlide = true;
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 1.0),
                                        child: Image.network(
                                          widget.list[index]['thumbnailSmall'],
                                          width: 30,
                                          height: 60,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width /
                                        2), // 手动添加的最后一个项
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "尺寸:${wallpaper['resolution']}",
                                  style: const TextStyle(color: Colors.black),
                                ),
                                Text(
                                  "大小:${formatBytes(wallpaper['fileSize'])}",
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        right: 16.0,
                        bottom: 120.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            RawMaterialButton(
                              onPressed: () {
                                // Add your onPressed code here!
                              },
                              child: SvgPicture.asset(
                                "assets/icon/like.svg",
                                height: 35,
                                width: 35,
                              ),
                              elevation: 0.0,
                              fillColor: Colors.transparent,
                              shape: CircleBorder(),
                            ),
                            SizedBox(height: 16.0),
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
    );
  }
}
