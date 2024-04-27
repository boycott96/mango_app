import 'package:dio/dio.dart';
import 'package:flutter_application_test/api/api.dart';

class UserService {
  signUp(data) {
    return ApiService().post("/user/sign/up", data);
  }

  signIn(Object data) async {
    return await ApiService().post("/user/sign/in", data);
  }

  getInfo() async {
    Response res = await ApiService().get("/user/info");
    print("###");
    print(res.data);
    return ;
  }
}

class Token {
  late String accessToken;
}
