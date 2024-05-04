import 'package:flutter_application_test/api/api.dart';

class WallpaperService {
  static hot() async {
    return await ApiService().get("/wallpaper/hot");
  }

  static category(String limit) async {
    return await ApiService().get("/wallpaper/category?limit=$limit");
  }
}