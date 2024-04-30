import 'package:flutter_application_test/api/api.dart';

class UserService {
  signUp(data) {
    return ApiService().post("/user/sign/up", data);
  }

  signIn(Object data) async {
    return await ApiService().post("/user/sign/in", data);
  }

  getInfo() async {
    return await ApiService().get("/user/info");
  }
}

class Token {
  late String accessToken;
}
