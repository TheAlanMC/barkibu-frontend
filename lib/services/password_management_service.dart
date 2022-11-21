import 'dart:convert';
import 'package:barkibu/dto/dto.dart';
import 'package:barkibu/services/services.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:barkibu/services/services.dart' as services;

class PasswordManagementService {
  static Future<String> sendEmail(String email) async {
    String baseUrl = services.baseUrl;
    final header = {'Content-Type': 'application/json', 'Accept': 'application/json'};
    final body = {'email': email};
    final url = Uri.parse('$baseUrl/v1/api/recovery-account');
    final response = await http.post(url, headers: header, body: json.encode(body));
    ResponseDto responseDto = ResponseDto.fromJson(response.body);
    if (response.statusCode != 200) {
      throw BarkibuException(responseDto.statusCode);
    }
    return responseDto.result;
  }

  static Future<String> sendCode(String email, String code) async {
    String baseUrl = services.baseUrl;
    final header = {'Content-Type': 'application/json', 'Accept': 'application/json'};
    final body = {'email': email, 'hashCode': code};
    final url = Uri.parse('$baseUrl/v1/api/recovery-account/hash-code');
    final response = await http.post(url, headers: header, body: json.encode(body));
    ResponseDto responseDto = ResponseDto.fromJson(response.body);
    if (response.statusCode != 200) {
      throw BarkibuException(responseDto.statusCode);
    }
    return responseDto.result;
  }

  static Future<String> updatePassword(String email, String code, String password, String confirmPassword) async {
    String baseUrl = services.baseUrl;
    final header = {'Content-Type': 'application/json', 'Accept': 'application/json'};
    final body = {'email': email, 'hashCode': code, 'password': password, 'confirmPassword': confirmPassword};
    final url = Uri.parse('$baseUrl/v1/api/recovery-account/password');
    final response = await http.post(url, headers: header, body: json.encode(body));
    ResponseDto responseDto = ResponseDto.fromJson(response.body);
    if (response.statusCode != 200) {
      throw BarkibuException(responseDto.statusCode);
    }
    return responseDto.result;
  }

  static Future<String> changePassword(String currentPassword, String newPassword, String confirmNewPassword) async {
    String token = await TokenSecureStorage.readToken();
    String baseUrl = services.baseUrl;
    final header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = {'currentPassword': currentPassword, 'newPassword': newPassword, 'confirmNewPassword': confirmNewPassword};
    final url = Uri.parse('$baseUrl/v1/api/user/password');
    final response = await http.put(url, headers: header, body: json.encode(body));
    ResponseDto responseDto = ResponseDto.fromJson(response.body);
    if (response.statusCode != 200) {
      if (responseDto.statusCode == 'SCTY-2002') {
        await RefreshTokenService.refreshToken();
        return changePassword(currentPassword, newPassword, confirmNewPassword);
      }
      throw BarkibuException(responseDto.statusCode);
    }
    return responseDto.result;
  }
}
