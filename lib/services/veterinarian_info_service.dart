import 'package:barkibu/dto/dto.dart';
import 'package:barkibu/utils/barkibu_exception.dart';
import 'package:http/http.dart' as http;
import 'package:barkibu/services/services.dart' as services;

class VeterinarianInfoService {
  static Future<VeterinarianInfoDto> getVeterinarianInfo(String token) async {
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
      throw BarkibuException(responseDto.statusCode);
    }
    return VeterinarianInfoDto.fromMap(responseDto.result);
  }

  static Future<VeterinarianRankingDto> getVeterinarianRanking(String token) async {
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
      throw BarkibuException(responseDto.statusCode);
    }
    return VeterinarianRankingDto.fromMap(responseDto.result);
  }

  static Future<VeterinarianReputationDto> getVeterinarianReputation(String token) async {
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
      throw BarkibuException(responseDto.statusCode);
    }
    return VeterinarianReputationDto.fromMap(responseDto.result);
  }

  static Future<List<VeterinarianContributionDto>> getVeterinarianContributions(String token) async {
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
      throw BarkibuException(responseDto.statusCode);
    }
    return (responseDto.result as List).map((e) => VeterinarianContributionDto.fromMap(e)).toList();
  }
}
