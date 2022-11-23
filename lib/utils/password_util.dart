import 'dart:convert';

import 'package:barkibu/utils/barkibu_exception.dart';
import 'package:crypto/crypto.dart';
import 'package:password_strength/password_strength.dart';

class PasswordUtil {
  static String sha256Password(String password) {
    return sha256.convert(utf8.encode(password)).toString();
  }

  static bool validatePasswordLength(String password) {
    return password.length >= 12;
  }

  static bool validatePasswordStrength(String password) {
    return estimatePasswordStrength(password) >= 0.7;
  }

  static bool validatPasswordConfirmation(String password, String confirmPassword) {
    return password == confirmPassword;
  }

  static void validatePassword(String password, String confirmPassword) {
    if (!validatePasswordLength(password)) {
      throw BarkibuException('SCTY-6000');
    }
    if (!validatePasswordStrength(password)) {
      throw BarkibuException('SCTY-6001');
    }
    if (!validatPasswordConfirmation(password, confirmPassword)) {
      throw BarkibuException('SCTY-6002');
    }
  }
}
