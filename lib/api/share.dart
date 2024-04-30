import 'package:flutter_application_test/api/api.dart';

class ShareService {
  static addAlbum(data) {
    return ApiService().post("/share/album/add", data);
  }

  static addSong(data) {
    return ApiService().post("/share/song/add", data);
  }
}
