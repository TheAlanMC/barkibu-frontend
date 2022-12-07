import 'dart:convert';

import 'package:barkibu/dto/dto.dart';
import 'package:barkibu/services/services.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:barkibu/services/services.dart' as services;
import 'package:http/http.dart' as http;

class PetTreatmentService {
  static Future<List<PetTreatmentDto>> getPetTreatments(int petId) async {
    String token = await TokenSecureStorage.readToken();
    String baseUrl = services.baseUrl;
    final header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final url = Uri.parse('$baseUrl/v1/api/pet/treatment/$petId');
    final response = await http.get(url, headers: header);
    ResponseDto responseDto = ResponseDto.fromJson(response.body);
    if (response.statusCode != 200) {
      if (responseDto.statusCode == 'SCTY-2002') {
        await RefreshTokenService.refreshToken();
        return getPetTreatments(petId);
      }
      throw BarkibuException(responseDto.statusCode);
    }
    return List<PetTreatmentDto>.from(responseDto.result.map((x) => PetTreatmentDto.fromMap(x)));
  }

  static Future<String> createPetTreatment(int petId, int treatmentId, String treatmentLastDate, String treatmentNextDate) async {
    String token = await TokenSecureStorage.readToken();
    String baseUrl = services.baseUrl;
    final header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = {
      'petId': petId,
      'treatmentId': treatmentId,
      'treatmentLastDate': '${treatmentLastDate}T04:00:00.000Z',
      'treatmentNextDate': '${treatmentNextDate}T04:00:00.000Z',
    };
    final url = Uri.parse('$baseUrl/v1/api/pet/treatment');
    final response = await http.post(url, headers: header, body: jsonEncode(body));
    ResponseDto responseDto = ResponseDto.fromJson(response.body);
    if (response.statusCode != 200) {
      if (responseDto.statusCode == 'SCTY-2002') {
        await RefreshTokenService.refreshToken();
        return createPetTreatment(petId, treatmentId, treatmentLastDate, treatmentNextDate);
      }
      throw BarkibuException(responseDto.statusCode);
    }
    return responseDto.result;
  }

  static Future<List<TreatmentDto>> getTreatments() async {
    String token = await TokenSecureStorage.readToken();
    String baseUrl = services.baseUrl;
    final header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final url = Uri.parse('$baseUrl/v1/api/treatment');
    final response = await http.get(url, headers: header);
    ResponseDto responseDto = ResponseDto.fromJson(response.body);
    if (response.statusCode != 200) {
      if (responseDto.statusCode == 'SCTY-2002') {
        await RefreshTokenService.refreshToken();
        return getTreatments();
      }
      throw BarkibuException(responseDto.statusCode);
    }
    return List<TreatmentDto>.from(responseDto.result.map((x) => TreatmentDto.fromMap(x)));
  }

  static Future<String> updatePetTreatment(int petTreatmentId, int petId, int treatmentId, String treatmentLastDate, String treatmentNextDate) async {
    String token = await TokenSecureStorage.readToken();
    String baseUrl = services.baseUrl;
    final header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = {
      'petTreatmentId': petTreatmentId,
      'treatmentId': treatmentId,
      'petId': petId,
      'treatmentLastDate': '${treatmentLastDate}T04:00:00.000Z',
      'treatmentNextDate': '${treatmentNextDate}T04:00:00.000Z',
    };
    final url = Uri.parse('$baseUrl/v1/api/pet/treatment');
    final response = await http.put(url, headers: header, body: jsonEncode(body));
    ResponseDto responseDto = ResponseDto.fromJson(response.body);
    if (response.statusCode != 200) {
      if (responseDto.statusCode == 'SCTY-2002') {
        await RefreshTokenService.refreshToken();
        return updatePetTreatment(petTreatmentId, petId, treatmentId, treatmentLastDate, treatmentNextDate);
      }
      throw BarkibuException(responseDto.statusCode);
    }
    return responseDto.result;
  }

  static Future<String> deletePetTreatment(int petTreatmentId) async {
    String token = await TokenSecureStorage.readToken();
    String baseUrl = services.baseUrl;
    final header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final url = Uri.parse('$baseUrl/v1/api/pet/treatment/$petTreatmentId');
    final response = await http.delete(url, headers: header);
    ResponseDto responseDto = ResponseDto.fromJson(response.body);
    if (response.statusCode != 200) {
      if (responseDto.statusCode == 'SCTY-2002') {
        await RefreshTokenService.refreshToken();
        return deletePetTreatment(petTreatmentId);
      }
      throw BarkibuException(responseDto.statusCode);
    }
    return responseDto.result;
  }
}
