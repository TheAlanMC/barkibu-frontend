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
}
