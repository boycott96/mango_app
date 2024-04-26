String validateRequired(String? value) {
  if (value == null || value == '') {
    return 'This is required';
  }
  return "";
}

String validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email is required';
  }
  // 使用正则表达式检查邮箱格式
  final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (!emailRegExp.hasMatch(value)) {
    return 'Enter a valid email';
  }
  return "";
}

String validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password is required';
  }
  // 使用正则表达式检查密码格式
  final passwordRegExp = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{4,20}$');
  if (!passwordRegExp.hasMatch(value)) {
    return 'Password must have 1 letter & 1 number, 4-20 chars';
  }
  return "";
}
