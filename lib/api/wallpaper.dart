import 'package:flutter/material.dart';
import 'package:flutter_application_test/api/api.dart';

class WallpaperService {
  late BuildContext context;

  WallpaperService(this.context);

  category(String limit) async {
    return await ApiService(context).get("/wallpaper/category?limit=$limit");
  }

  trending(int pageNum) async {
    return await ApiService(context).get("/wallpaper/trending?page=$pageNum");
  }

  recent(int pageNum) async {
    return await ApiService(context).get("/wallpaper/recent?page=$pageNum");
  }

  topNew(int pageNum) async {
    return await ApiService(context).get("/wallpaper/new?page=$pageNum");
  }

  info(String id) async {
    return await ApiService(context).get("/wallpaper/detail?id=$id");
  }

  wallpaperForCategory(int categoryId, int page) async {
    return await ApiService(context)
        .get("/wallpaper/category/wallpaper?categoryId=$categoryId&page=$page");
  }
}
