import 'dart:convert';

import 'package:barkibu/dto/dto.dart';
import 'package:http/http.dart' as http;

class LoginService {
  static String baseUrl = 'http://10.147.17.209:7777';
  static Future<LoginResponseDto> login(String username, String password) async {
    final body = {'userName': username, 'password': password};
    final header = {'Content-Type': 'application/json', 'Accept': 'application/json'};
    final url = Uri.parse('$baseUrl/v1/api/auth');
    final response = await http.post(url, headers: header, body: json.encode(body));
    if (response.statusCode == 200) {
      return LoginResponseDto.fromJson(response.body);
    } else {
      throw Exception('Failed to login');
    }

    // if (username == "jperez" && password == "123456") {
    //   return LoginResponseDto(
    //     success: true,
    //     token: "ey123hg123h123.12h323.adasd",
    //     refreshToken: "ey123hg123h123.12h323.adasd",
    //   );
    // } else if (username == "mgomez") {
    //   throw Exception("Error de comunicación con internet");
    // } else {
    //   return LoginResponseDto(success: false);
    // }
  }
}
