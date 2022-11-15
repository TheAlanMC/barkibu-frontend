import 'dart:convert';

import 'package:barkibu/dto/dto.dart';
import 'package:barkibu/utils/barkibu_exception.dart';
import 'package:http/http.dart' as http;
import 'package:barkibu/services/services.dart' as services;

class RegisterUserService {
  static Future<String> registerUser(
      String firstName, String lastName, String userName, String email, String password, String confirmPassword) async {
    String baseUrl = services.baseUrl;
    final body = {
      'firstName': firstName,
      'lastName': lastName,
      'userName': userName,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword
    };
    final header = {'Content-Type': 'application/json', 'Accept': 'application/json'};
    final url = Uri.parse('$baseUrl/v1/api/user/pet-owner');
    final response = await http.post(url, headers: header, body: json.encode(body));
    ResponseDto responseDto = ResponseDto.fromJson(response.body);
    if (response.statusCode != 200) {
      throw BarkibuException(responseDto.statusCode);
    }
    return responseDto.result;
  }
}
