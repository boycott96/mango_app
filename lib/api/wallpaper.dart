import 'package:flutter_application_test/api/api.dart';

class WallpaperService {
  static hot() async {
    return await ApiService().get("/wallpaper/hot");
  }

  static category(String limit) async {
    return await ApiService().get("/wallpaper/category?limit=$limit");
  }

  static trending() async {
    return await ApiService().get("/wallpaper/trending");
  }

  static recent() async {
    return await ApiService().get("/wallpaper/recent");
  }
  
  static topNew() async {
    return await ApiService().get("/wallpaper/new");
  }

  static info(String id) async {
    return await ApiService().get("/wallpaper/detail?id=$id");
  }
}