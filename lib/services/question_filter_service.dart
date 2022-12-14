import 'dart:convert';

import 'package:barkibu/dto/dto.dart';
import 'package:barkibu/services/services.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:barkibu/services/services.dart' as services;
import 'package:http/http.dart' as http;

class QuestionFilterService {
  static Future<List<CategoryDto>> getCategories() async {
    String token = await TokenSecureStorage.readToken();
    String baseUrl = services.baseUrl;
    final header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final url = Uri.parse('$baseUrl/v1/api/category');
    final response = await http.get(url, headers: header);
    ResponseDto responseDto = ResponseDto.fromJson(response.body);
    if (response.statusCode != 200) {
      if (responseDto.statusCode == 'SCTY-2002') {
        await RefreshTokenService.refreshToken();
        return getCategories();
      }
      throw BarkibuException(responseDto.statusCode);
    }
    return List<CategoryDto>.from(responseDto.result.map((x) => CategoryDto.fromMap(x)));
  }

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
    return List<SpecieDto>.from(responseDto.result.map((x) => SpecieDto.fromMap(x)));
  }

  static Future<List<SymptomDto>> getSymptom() async {
    String token = await TokenSecureStorage.readToken();
    String baseUrl = services.baseUrl;
    final header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final url = Uri.parse('$baseUrl/v1/api/symptom');
    final response = await http.get(url, headers: header);
    ResponseDto responseDto = ResponseDto.fromJson(response.body);
    if (response.statusCode != 200) {
      if (responseDto.statusCode == 'SCTY-2002') {
        await RefreshTokenService.refreshToken();
        return getSymptom();
      }
      throw BarkibuException(responseDto.statusCode);
    }
    return List<SymptomDto>.from(responseDto.result.map((x) => SymptomDto.fromMap(x)));
  }

  static Future<List<VeterinarianQuestionFilterDto>> getQuestions(String categoryId, String specieId, String answered, int page) async {
    String token = await TokenSecureStorage.readToken();
    String baseUrl = services.baseUrl;
    final header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = {'categoryId': categoryId, 'specieId': specieId, 'answered': answered};
    final url = Uri.parse('$baseUrl/v1/api/question/veterinarian-filter?page=$page');
    final response = await http.post(url, headers: header, body: jsonEncode(body));
    ResponseDto responseDto = ResponseDto.fromJson(response.body);
    if (response.statusCode != 200) {
      if (responseDto.statusCode == 'SCTY-2002') {
        await RefreshTokenService.refreshToken();
        return getQuestions(categoryId, specieId, answered, page);
      }
      throw BarkibuException(responseDto.statusCode);
    }
    return List<VeterinarianQuestionFilterDto>.from(responseDto.result.map((x) => VeterinarianQuestionFilterDto.fromMap(x)));
  }

  static Future<List<VeterinarianQuestionFilterDto>> getQuestionsOwner(String categoryId, String specieId, String answered, int page) async {
    String token = await TokenSecureStorage.readToken();
    String baseUrl = services.baseUrl;
    final header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = {'categoryId': categoryId, 'specieId': specieId, 'answered': answered};
    final url = Uri.parse('$baseUrl/v1/api/question/owner-filter?page=$page');
    final response = await http.post(url, headers: header, body: jsonEncode(body));
    ResponseDto responseDto = ResponseDto.fromJson(response.body);
    if (response.statusCode != 200) {
      if (responseDto.statusCode == 'SCTY-2002') {
        await RefreshTokenService.refreshToken();
        return getQuestionsOwner(categoryId, specieId, answered, page);
      }
      throw BarkibuException(responseDto.statusCode);
    }
    return List<VeterinarianQuestionFilterDto>.from(responseDto.result.map((x) => VeterinarianQuestionFilterDto.fromMap(x)));
  }

  static Future<String> registerQuestion(int categoryId, int petId, String problem, String detailedDescription, List<int> symptoms) async {
    String token = await TokenSecureStorage.readToken();
    String baseUrl = services.baseUrl;
    final header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = {
      'categoryId': categoryId,
      'petId': petId,
      'problem': problem,
      'detailedDescription': detailedDescription,
      'symptomIdList': symptoms,
    };
    final url = Uri.parse('$baseUrl/v1/api/new-question');
    final response = await http.post(url, headers: header, body: json.encode(body));
    ResponseDto responseDto = ResponseDto.fromJson(response.body);
    if (response.statusCode != 200) {
      if (responseDto.statusCode == 'SCTY-2002') {
        await RefreshTokenService.refreshToken();
        return registerQuestion(categoryId, petId, problem, detailedDescription, symptoms);
      }
      throw BarkibuException(responseDto.statusCode);
    }
    return responseDto.result;
  }
}
