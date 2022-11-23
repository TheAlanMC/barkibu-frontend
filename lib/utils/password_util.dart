import 'dart:convert';

import 'package:crypto/crypto.dart';

class PasswordUtil {
  static String sha256Password(String password) {
    return sha256.convert(utf8.encode(password)).toString();
  }
}
