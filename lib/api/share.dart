import 'package:flutter/material.dart';
import 'package:flutter_application_test/api/api.dart';

class ShareService {
  late BuildContext context;

  ShareService(this.context);

  addAlbum(data) {
    return ApiService(context).post("/share/album/add", data);
  }

  addSong(data) {
    return ApiService(context).post("/share/song/add", data);
  }
}
