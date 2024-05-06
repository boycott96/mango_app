import 'package:flutter/material.dart';
import 'package:flutter_application_test/api/api.dart';

class UserService {
  late BuildContext context;

  UserService(this.context);

  signUp(data) {
    return ApiService(context).post("/user/sign/up", data);
  }

  signIn(Object data) async {
    return await ApiService(context).post("/user/sign/in", data);
  }

  signOut() async {
    return await ApiService(context).post("/user/sign/put", {});
  }

  getInfo() async {
    return await ApiService(context).get("/user/info");
  }
}

class Token {
  late String accessToken;
}
