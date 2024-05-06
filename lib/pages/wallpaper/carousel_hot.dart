import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_test/api/wallpaper.dart';
import 'package:flutter_application_test/pages/wallpaper/wallpaper_detail.dart';

class CarouselHot extends StatefulWidget {
  const CarouselHot({super.key});

  @override
  State<CarouselHot> createState() => _CarouselHot();
}

class _CarouselHot extends State<CarouselHot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _currentIndex = 0;
  List<dynamic> _images = [];
  @override
  void initState() {
    super.initState();
    getHot(context);
    _controller = AnimationController(vsync: this);
  }

  // 获取最流行的三张壁纸
  void getHot(BuildContext context) async {
    Response response = await WallpaperService(context).hot();
    if (response.data['code'] == 0) {
      setState(() {
        _images = response.data['data'];
      });
    } else if (response.data['code'] == '401') {}
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 180.0,
            enlargeCenterPage: true,
            autoPlay: false,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: _images.map((image) {
            return Builder(
              builder: (BuildContext context) {
                return GestureDetector(
                  onTap: () {
                    viewWallpaper(image['id']);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    // margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey,
                    ),
                    child: ClipRRect(
                      // 使用ClipRRect进行剪裁以保证圆角效果
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        image['thumbnailLarge'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _images.map((image) {
            int index = _images.indexOf(image);
            return Container(
              width: _currentIndex == index ? 22.0 : 8.0,
              height: 8.0,
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                // shape: _currentIndex == index ? BoxShape.rectangle :BoxShape.circle,
                borderRadius: _currentIndex == index
                    ? BorderRadius.circular(20)
                    : BorderRadius.circular(20),
                color: _currentIndex == index
                    ? const Color.fromRGBO(152, 152, 152, 1)
                    : const Color.fromRGBO(227, 227, 227, 1),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
