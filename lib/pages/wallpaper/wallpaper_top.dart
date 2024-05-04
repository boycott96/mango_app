import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WallpaperTop extends StatefulWidget {
  const WallpaperTop({super.key});

  @override
  State<WallpaperTop> createState() => _WallpaperTopState();
}

class _WallpaperTopState extends State<WallpaperTop>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  String _activeType = "Trending";
  final List<dynamic> _btn = [
    {
      "icon": "assets/icon/top_trending.svg",
      "active_icon": "assets/icon/top_trending_active.svg",
      "label": "Trending",
      "width": "22",
    },
    {
      "icon": "assets/icon/top_recent.svg",
      "active_icon": "assets/icon/top_recent_active.svg",
      "label": "Recent",
      "width": "25",
    },
    {
      "icon": "assets/icon/top_new.svg",
      "active_icon": "assets/icon/top_new_active.svg",
      "label": "New",
      "width": "25",
    },
  ];

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
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          margin: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: Color.fromRGBO(225, 244, 255, 1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: _btn
                .map(
                  (e) => Container(
                    width: (MediaQuery.of(context).size.width - 32 - 21) * 0.33,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: _activeType == e['label']
                          ? const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color.fromRGBO(103, 71, 231, 1),
                                Color.fromRGBO(0, 255, 240, 1),
                              ],
                            )
                          : null,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _activeType = e['label'];
                        });
                      },
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            _activeType == e['label']
                                ? e['active_icon']
                                : e['icon'],
                            width: double.parse(e['width']),
                          ),
                          Text(
                            e['label'],
                            style: TextStyle(
                              color: _activeType == e['label']
                                  ? Colors.white
                                  : Color.fromRGBO(71, 71, 227, 1),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.transparent),
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(vertical: 3)),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        )
      ],
    );
  }
}
