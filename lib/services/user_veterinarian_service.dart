import 'dart:convert';

import 'package:barkibu/dto/dto.dart';
import 'package:barkibu/services/services.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:barkibu/services/services.dart' as services;

class UserVeterinarianService {
  static Future<UserVeterinarianDto> getUserVeterinarian() async {
    String token = await TokenSecureStorage.readToken();
    String baseUrl = services.baseUrl;
    final header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final url = Uri.parse('$baseUrl/v1/api/user/veterinarian');
    final response = await http.get(url, headers: header);
    ResponseDto responseDto = ResponseDto.fromJson(response.body);
    if (response.statusCode != 200) {
      if (responseDto.statusCode == 'SCTY-2002') {
        await RefreshTokenService.refreshToken();
        return getUserVeterinarian();
      }
      throw BarkibuException(responseDto.statusCode);
    }
    return UserVeterinarianDto.fromMap(responseDto.result);
  }

  static Future<String> updateUserVeterinarian(
      String firstName, String lastName, int cityId, String userName, String email, String description, String? photoPath) async {
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
      'cityId': cityId,
      'userName': userName,
      'email': email,
      'description': description,
      'photoPath': photoPath
    };
    final url = Uri.parse('$baseUrl/v1/api/user/veterinarian');
    final response = await http.put(url, headers: header, body: json.encode(body));
    ResponseDto responseDto = ResponseDto.fromJson(response.body);
    if (response.statusCode != 200) {
      if (responseDto.statusCode == 'SCTY-2002') {
        await RefreshTokenService.refreshToken();
        return updateUserVeterinarian(firstName, lastName, cityId, userName, email, description, photoPath);
      }
      throw BarkibuException(responseDto.statusCode);
    }
    return responseDto.result;
  }
}
