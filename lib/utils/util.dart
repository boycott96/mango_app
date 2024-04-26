import 'dart:convert';

import 'package:crypto/crypto.dart';

String hashPassword(String password) {
  var bytes = utf8.encode(password); // 将密码转换为字节序列
  var digest = sha256.convert(bytes); // 使用 SHA-256 哈希函数对密码进行加密
  return digest.toString(); // 返回加密后的密码（哈希值）
}
