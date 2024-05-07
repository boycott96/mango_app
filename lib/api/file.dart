import 'package:flutter/material.dart';
import 'package:flutter_application_test/api/api.dart';

class FileService {
  late BuildContext context;

  FileService(this.context);

   uploadFile(data) {
    return ApiService(context).post("/file/upload", data);
  }
}
