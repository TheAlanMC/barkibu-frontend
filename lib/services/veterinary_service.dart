import 'dart:convert';

import 'package:barkibu/dto/dto.dart';
import 'package:barkibu/services/services.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:barkibu/services/services.dart' as services;

class VeterinaryService {
  static Future<VeterinaryDto> getVeterinary() async {
    String token = await TokenSecureStorage.readToken();
    String baseUrl = services.baseUrl;
    final header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final url = Uri.parse('$baseUrl/v1/api/veterinary');
    final response = await http.get(url, headers: header);
    ResponseDto responseDto = ResponseDto.fromJson(response.body);
    if (response.statusCode != 200) {
      if (responseDto.statusCode == 'SCTY-2002') {
        await RefreshTokenService.refreshToken();
        return getVeterinary();
      }
      throw BarkibuException(responseDto.statusCode);
    }
    return VeterinaryDto.fromMap(responseDto.result);
  }

  static Future<String> registerVeterinary(String name, String address, double latitude, double longitude, String description) async {
    String token = await TokenSecureStorage.readToken();
    String baseUrl = services.baseUrl;
    final header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = {
      'name': name,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'description': description,
    };
    final url = Uri.parse('$baseUrl/v1/api/veterinary');
    final response = await http.post(url, headers: header, body: json.encode(body));
    ResponseDto responseDto = ResponseDto.fromJson(response.body);
    if (response.statusCode != 200) {
      if (responseDto.statusCode == 'SCTY-2002') {
        await RefreshTokenService.refreshToken();
        return registerVeterinary(name, address, latitude, longitude, description);
      }
      throw BarkibuException(responseDto.statusCode);
    }
    return responseDto.result;
  }

  static Future<String> updateVeterinary(String name, String address, double latitude, double longitude, String description) async {
    String token = await TokenSecureStorage.readToken();
    String baseUrl = services.baseUrl;
    final header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = {
      'name': name,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'description': description,
    };
    final url = Uri.parse('$baseUrl/v1/api/veterinary');
    final response = await http.put(url, headers: header, body: json.encode(body));
    ResponseDto responseDto = ResponseDto.fromJson(response.body);
    if (response.statusCode != 200) {
      if (responseDto.statusCode == 'SCTY-2002') {
        await RefreshTokenService.refreshToken();
        return registerVeterinary(name, address, latitude, longitude, description);
      }
      throw BarkibuException(responseDto.statusCode);
    }
    return responseDto.result;
  }
}
