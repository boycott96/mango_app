import 'package:flutter_application_test/api/api.dart';

class UserService {
  signUp(data) {
    return ApiService().post("/user/sign/up", data);
  }

  signIn(Object data) async {
    var data = {
      "email": "123",
      "password": "123",
    };
    return await ApiService().post("/user/sign/in", data);
  }
}

class Token {
  late String accessToken;
}
