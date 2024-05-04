import 'package:flutter/material.dart';
import 'package:flutter_application_test/pages/wallpaper/category_view.dart';
import 'package:flutter_application_test/pages/wallpaper/wallpaper_top.dart';

import 'carousel_hot.dart';

class WallpaperScreen extends StatefulWidget {
  const WallpaperScreen({super.key});

  @override
  State<WallpaperScreen> createState() => _WallpaperScreenState();
}

class _WallpaperScreenState extends State<WallpaperScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: const SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            CarouselHot(),
            CategoryView(),
            WallpaperTop(),
          ],
        ),
      ),
    );
  }
}
