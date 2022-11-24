import 'dart:convert';

import 'package:barkibu/dto/dto.dart';
import 'package:barkibu/services/services.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:barkibu/services/services.dart' as services;

class UserPetOwnerService {
  static Future<UserPetOwnerDto> getUserPetOwner() async {
    String token = await TokenSecureStorage.readToken();
    String baseUrl = services.baseUrl;
    final header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final url = Uri.parse('$baseUrl/v1/api/user/pet-owner');
    final response = await http.get(url, headers: header);
    ResponseDto responseDto = ResponseDto.fromJson(response.body);
    if (response.statusCode != 200) {
      if (responseDto.statusCode == 'SCTY-2002') {
        await RefreshTokenService.refreshToken();
        return getUserPetOwner();
      }
      throw BarkibuException(responseDto.statusCode);
    }
    return UserPetOwnerDto.fromMap(responseDto.result);
  }

  static Future<String> updateUserPetOwner(String firstName, String lastName, String userName, String email) async {
    String token = await TokenSecureStorage.readToken();
    String baseUrl = services.baseUrl;
    final header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = {'firstName': firstName, 'lastName': lastName, 'userName': userName, 'email': email};
    final url = Uri.parse('$baseUrl/v1/api/user/pet-owner');
    final response = await http.put(url, headers: header, body: json.encode(body));
    ResponseDto responseDto = ResponseDto.fromJson(response.body);
    if (response.statusCode != 200) {
      if (responseDto.statusCode == 'SCTY-2002') {
        await RefreshTokenService.refreshToken();
        return updateUserPetOwner(firstName, lastName, userName, email);
      }
      throw BarkibuException(responseDto.statusCode);
    }
    return responseDto.result;
  }
}
