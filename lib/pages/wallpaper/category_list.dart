import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_test/api/wallpaper.dart';
import 'package:flutter_application_test/pages/wallpaper/wallpaper_list.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<dynamic> _categoryList = [];
  @override
  void initState() {
    super.initState();
    getCategory(context);
    _controller = AnimationController(vsync: this);
  }

  void getCategory(BuildContext context) async {
    Response response = await WallpaperService(context).category('');
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
    return Scaffold(
        appBar: AppBar(
          title: const Text("Category"),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Wrap(
              spacing: 12.0, // 水平方向子部件之间的间距
              runSpacing: 12.0, // 垂直方向的间距
              children: _categoryList.asMap().entries.map((entry) {
                final e = entry.value;
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                WallpaperList(categoryId: e['id'])));
                  },
                  child: Container(
                    width: (MediaQuery.of(context).size.width - 64) *
                        0.33, // 设置容器宽度为屏幕宽度的20%
                    height: 90,
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
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          e['name'],
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis, // 设置文本宽度缩写
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ));
  }
}
