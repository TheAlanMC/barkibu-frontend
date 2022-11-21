import 'package:barkibu/dto/dto.dart';
import 'package:barkibu/services/services.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:barkibu/services/services.dart' as services;

class VeterinarianInfoService {
  static Future<VeterinarianInfoDto> getVeterinarianInfo() async {
    String token = await TokenSecureStorage.readToken();
    String baseUrl = services.baseUrl;
    final header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final url = Uri.parse('$baseUrl/v1/api/veterinarian');
    final response = await http.get(url, headers: header);
    ResponseDto responseDto = ResponseDto.fromJson(response.body);
    if (response.statusCode != 200) {
      if (responseDto.statusCode == 'SCTY-2002') {
        await RefreshTokenService.refreshToken();
        return getVeterinarianInfo();
      }
      throw BarkibuException(responseDto.statusCode);
    }
    return VeterinarianInfoDto.fromMap(responseDto.result);
  }

  static Future<VeterinarianRankingDto> getVeterinarianRanking() async {
    String token = await TokenSecureStorage.readToken();
    String baseUrl = services.baseUrl;
    final header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final url = Uri.parse('$baseUrl/v1/api/veterinarian/ranking');
    final response = await http.get(url, headers: header);
    ResponseDto responseDto = ResponseDto.fromJson(response.body);
    if (response.statusCode != 200) {
      if (responseDto.statusCode == 'SCTY-2002') {
        await RefreshTokenService.refreshToken();
        return getVeterinarianRanking();
      }
      throw BarkibuException(responseDto.statusCode);
    }
    return VeterinarianRankingDto.fromMap(responseDto.result);
  }

  static Future<VeterinarianReputationDto> getVeterinarianReputation() async {
    String token = await TokenSecureStorage.readToken();
    String baseUrl = services.baseUrl;
    final header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final url = Uri.parse('$baseUrl/v1/api/veterinarian/reputation');
    final response = await http.get(url, headers: header);
    ResponseDto responseDto = ResponseDto.fromJson(response.body);
    if (response.statusCode != 200) {
      if (responseDto.statusCode == 'SCTY-2002') {
        await RefreshTokenService.refreshToken();
        return getVeterinarianReputation();
      }
      throw BarkibuException(responseDto.statusCode);
    }
    return VeterinarianReputationDto.fromMap(responseDto.result);
  }

  static Future<List<VeterinarianContributionDto>> getVeterinarianContributions() async {
    String token = await TokenSecureStorage.readToken();
    String baseUrl = services.baseUrl;
    final header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final url = Uri.parse('$baseUrl/v1/api/veterinarian/contribution');
    final response = await http.get(url, headers: header);
    ResponseDto responseDto = ResponseDto.fromJson(response.body);
    if (response.statusCode != 200) {
      if (responseDto.statusCode == 'SCTY-2002') {
        await RefreshTokenService.refreshToken();
        return getVeterinarianContributions();
      }
      throw BarkibuException(responseDto.statusCode);
    }
    return (responseDto.result as List).map((e) => VeterinarianContributionDto.fromMap(e)).toList();
  }

  static Future<List<VeterinarianOwnAnswerDto>> getVeterinarianOwnAnswers() async {
    String token = await TokenSecureStorage.readToken();
    String baseUrl = services.baseUrl;
    final header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final url = Uri.parse('$baseUrl/v1/api/veterinarian/answers');
    final response = await http.get(url, headers: header);
    ResponseDto responseDto = ResponseDto.fromJson(response.body);
    if (response.statusCode != 200) {
      if (responseDto.statusCode == 'SCTY-2002') {
        await RefreshTokenService.refreshToken();
        return getVeterinarianOwnAnswers();
      }
      throw BarkibuException(responseDto.statusCode);
    }
    return (responseDto.result as List).map((e) => VeterinarianOwnAnswerDto.fromMap(e)).toList();
  }
}
