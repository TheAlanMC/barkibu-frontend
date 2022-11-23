import 'dart:convert';

import 'package:barkibu/dto/dto.dart';
import 'package:barkibu/services/services.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:barkibu/services/services.dart' as services;

class RegisterPetService {
  static Future<List<SpecieDto>> getSpecies() async {
    String token = await TokenSecureStorage.readToken();
    String baseUrl = services.baseUrl;
    final header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final url = Uri.parse('$baseUrl/v1/api/specie');
    final response = await http.get(url, headers: header);
    ResponseDto responseDto = ResponseDto.fromJson(response.body);
    if (response.statusCode != 200) {
      if (responseDto.statusCode == 'SCTY-2002') {
        await RefreshTokenService.refreshToken();
        return getSpecies();
      }
      throw BarkibuException(responseDto.statusCode);
    }
    return List.from(responseDto.result.map((x) => SpecieDto.fromMap(x)));
  }

  static Future<List<BreedDto>> getBreeds() async {
    String token = await TokenSecureStorage.readToken();
    String baseUrl = services.baseUrl;
    final header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final url = Uri.parse('$baseUrl/v1/api/breed');
    final response = await http.get(url, headers: header);
    ResponseDto responseDto = ResponseDto.fromJson(response.body);
    if (response.statusCode != 200) {
      if (responseDto.statusCode == 'SCTY-2002') {
        await RefreshTokenService.refreshToken();
        return getBreeds();
      }
      throw BarkibuException(responseDto.statusCode);
    }
    return List.from(responseDto.result.map((x) => BreedDto.fromMap(x)));
  }

  static Future<String> registerPet(
      int breedId, String name, String gender, bool castrated, DateTime bornDate, String photoPath, String? chipNumber) async {
    String token = await TokenSecureStorage.readToken();
    String baseUrl = services.baseUrl;
    final header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = {
      'breedId': breedId,
      'name': name,
      'gender': gender,
      'castrated': castrated,
      'bornDate': bornDate,
      'photoPath': photoPath,
      'chipNumber': chipNumber,
    };
    final url = Uri.parse('$baseUrl/v1/api/pet');
    final response = await http.post(url, headers: header, body: json.encode(body));
    ResponseDto responseDto = ResponseDto.fromJson(response.body);
    if (response.statusCode != 200) {
      if (responseDto.statusCode == 'SCTY-2002') {
        await RefreshTokenService.refreshToken();
        registerPet(breedId, name, gender, castrated, bornDate, photoPath, chipNumber);
      }
      throw BarkibuException(responseDto.statusCode);
    }
    return responseDto.result;
  }
}
