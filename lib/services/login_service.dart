import 'dart:convert';

import 'package:barkibu/dto/dto.dart';
import 'package:barkibu/utils/barkibu_exception.dart';
import 'package:http/http.dart' as http;
import 'package:barkibu/services/services.dart' as services;

class LoginService {
  static Future<LoginResponseDto> login(String username, String password) async {
    String baseUrl = services.baseUrl;
    final body = {'userName': username, 'password': password};
    final header = {'Content-Type': 'application/json', 'Accept': 'application/json'};
    final url = Uri.parse('$baseUrl/v1/api/auth');
    final response = await http.post(url, headers: header, body: json.encode(body));
    ResponseDto responseDto = ResponseDto.fromJson(response.body);
    if (response.statusCode != 200) {
      throw BarkibuException(responseDto.statusCode);
    }
    return LoginResponseDto.fromMap(responseDto.result);
  }

  static Future<List<String>> getGroups(String token) async {
    String baseUrl = services.baseUrl;
    final header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final url = Uri.parse('$baseUrl/v1/api/user/group');
    final response = await http.get(url, headers: header);
    ResponseDto responseDto = ResponseDto.fromJson(response.body);
    if (response.statusCode != 200) {
      throw BarkibuException(responseDto.statusCode);
    }
    return List<String>.from(responseDto.result);
  }
}
