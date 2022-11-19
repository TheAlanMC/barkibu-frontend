import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenSecureStorage {
  static FlutterSecureStorage storage = const FlutterSecureStorage();

  static Future<void> saveToken(String token, String refreshToken) async {
    await storage.write(key: 'token', value: token);
    await storage.write(key: 'refreshToken', value: refreshToken);
  }

  static Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }

  static Future<String> readRefreshToken() async {
    return await storage.read(key: 'refreshToken') ?? '';
  }

  static Future<void> deleteTokens() async {
    await storage.delete(key: 'token');
    await storage.delete(key: 'refreshToken');
  }
}
