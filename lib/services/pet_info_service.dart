import 'package:barkibu/dto/dto.dart';
import 'package:barkibu/services/services.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:barkibu/services/services.dart' as services;

class PetInfoService {
  static Future<List<PetInfoDto>> getPetInfo() async {
    String token = await TokenSecureStorage.readToken();
    String baseUrl = services.baseUrl;
    final header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final url = Uri.parse('$baseUrl/v1/api/pet/pet-info');
    final response = await http.get(url, headers: header);
    ResponseDto responseDto = ResponseDto.fromJson(response.body);
    if (response.statusCode != 200) {
      if (responseDto.statusCode == 'SCTY-2002') {
        await RefreshTokenService.refreshToken();
        return getPetInfo();
      }
      throw BarkibuException(responseDto.statusCode);
    }
    return List<PetInfoDto>.from(responseDto.result.map((x) => PetInfoDto.fromMap(x)));
  }
}
