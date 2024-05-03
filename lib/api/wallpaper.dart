import 'package:flutter_application_test/api/api.dart';

class WallpaperService {
  static hot() async {
    return await ApiService().get("/wallpaper/hot");
  }
}