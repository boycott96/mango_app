import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_test/api/wallpaper.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  List<dynamic> _categoryList = [];

  @override
  void initState() {
    super.initState();
    getCategory();
    _controller = AnimationController(vsync: this);
  }

  void getCategory() async {
    Response response = await WallpaperService.category("4");
    if (response.data['code'] == 0) {
      setState(() {
        _categoryList = response.data['data'];
        print(_categoryList);
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Category",
                style: TextStyle(
                  color: Color.fromRGBO(41, 50, 59, 1),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "View all",
                  style: TextStyle(
                    color: Color.fromRGBO(0, 113, 227, 1),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10), // 添加行与行之间的间距
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _categoryList.asMap().entries.map((entry) {
              final index = entry.key;
              final e = entry.value;
              return Container(
                width: (MediaQuery.of(context).size.width - 32 - 40) *
                    0.25, // 设置容器宽度为屏幕宽度的20%
                height: 70,
                margin: EdgeInsets.only(right: 10), // 添加每个容器之间的间距
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(e['categoryUrl']),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.5), // 黑色层的颜色和透明度
                      BlendMode.srcOver, // 混合模式，此处表示黑色层在顶部
                    ),
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      e['name'],
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis, // 设置文本宽度缩写
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
