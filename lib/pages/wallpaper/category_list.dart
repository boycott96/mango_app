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
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 1),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // 每行显示的列数
              crossAxisSpacing: 1, // 列之间的间距
              mainAxisSpacing: 1, // 行之间的间距
              childAspectRatio: 1, // 子组件的宽高比例
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final e = _categoryList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WallpaperList(
                          categoryId: e['id'],
                          name: e['zhName'],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(e['categoryUrl']),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.5), // 黑色层的颜色和透明度
                          BlendMode.srcOver, // 混合模式，此处表示黑色层在顶部
                        ),
                      ),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          e['zhName'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                          overflow: TextOverflow.ellipsis, // 设置文本宽度缩写
                        ),
                      ),
                    ),
                  ),
                );
              },
              childCount: _categoryList.length,
            ),
          ),
        ),
      ],
    );
  }
}
