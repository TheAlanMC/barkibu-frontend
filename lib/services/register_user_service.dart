import 'dart:convert';

import 'package:barkibu/dto/dto.dart';
import 'package:barkibu/services/services.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:barkibu/services/services.dart' as services;

class RegisterUserService {
  static Future<String> registerUser(
      String firstName, String lastName, String userName, String email, String password, String confirmPassword) async {
    String baseUrl = services.baseUrl;
    final header = {'Content-Type': 'application/json', 'Accept': 'application/json'};
    final body = {
      'firstName': firstName,
      'lastName': lastName,
      'userName': userName,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword
    };
    final url = Uri.parse('$baseUrl/v1/api/user/pet-owner');
    final response = await http.post(url, headers: header, body: json.encode(body));
    ResponseDto responseDto = ResponseDto.fromJson(response.body);
    if (response.statusCode != 200) {
      throw BarkibuException(responseDto.statusCode);
    }
    return responseDto.result;
  }

  static Future<String> registerUserVeterinarian(
      String firstName, String lastName, String userName, String email, String password, String confirmPassword) async {
    String token = await TokenSecureStorage.readToken();
    String baseUrl = services.baseUrl;
    final header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = {
      'firstName': firstName,
      'lastName': lastName,
      'userName': userName,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword
    };
    final url = Uri.parse('$baseUrl/v1/api/user/veterinarian');
    final response = await http.post(url, headers: header, body: json.encode(body));
    ResponseDto responseDto = ResponseDto.fromJson(response.body);
    if (response.statusCode != 200) {
      if (responseDto.statusCode == 'SCTY-2002') {
        await RefreshTokenService.refreshToken();
        return registerUserVeterinarian(firstName, lastName, userName, email, password, confirmPassword);
      }
      throw BarkibuException(responseDto.statusCode);
    }
    return responseDto.result;
  }
}
