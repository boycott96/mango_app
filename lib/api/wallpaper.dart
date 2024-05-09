import 'package:flutter/material.dart';
import 'package:flutter_application_test/api/api.dart';

class WallpaperService {
  late BuildContext context;

  WallpaperService(this.context);

  hot() async {
    return await ApiService(context).get("/wallpaper/hot");
  }

  category(String limit) async {
    return await ApiService(context).get("/wallpaper/category?limit=$limit");
  }

  trending() async {
    return await ApiService(context).get("/wallpaper/trending");
  }

  recent() async {
    return await ApiService(context).get("/wallpaper/recent");
  }

  topNew() async {
    return await ApiService(context).get("/wallpaper/new");
  }

  info(String id) async {
    return await ApiService(context).get("/wallpaper/detail?id=$id");
  }

  wallpaperForCategory(int categoryId, int page) async {
    return await ApiService(context).get("/wallpaper/category/wallpaper?categoryId=$categoryId&page=$page");
  }
}
