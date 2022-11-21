import 'package:barkibu/dto/dto.dart';
import 'package:barkibu/services/services.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:barkibu/services/services.dart' as services;

class CountryStateCityService {
  static Future<List<CountryDto>> getCountries() async {
    String token = await TokenSecureStorage.readToken();
    String baseUrl = services.baseUrl;
    final header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final url = Uri.parse('$baseUrl/v1/api/country');
    final response = await http.get(url, headers: header);
    ResponseDto responseDto = ResponseDto.fromJson(response.body);
    if (response.statusCode != 200) {
      if (responseDto.statusCode == 'SCTY-2002') {
        await RefreshTokenService.refreshToken();
        return getCountries();
      }
      throw BarkibuException(responseDto.statusCode);
    }
    return List<CountryDto>.from(responseDto.result.map((x) => CountryDto.fromMap(x)));
  }

  static Future<List<StateDto>> getStates() async {
    String token = await TokenSecureStorage.readToken();
    String baseUrl = services.baseUrl;
    final header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final url = Uri.parse('$baseUrl/v1/api/state');
    final response = await http.get(url, headers: header);
    ResponseDto responseDto = ResponseDto.fromJson(response.body);
    if (response.statusCode != 200) {
      if (responseDto.statusCode == 'SCTY-2002') {
        await RefreshTokenService.refreshToken();
        return getStates();
      }
      throw BarkibuException(responseDto.statusCode);
    }
    return List<StateDto>.from(responseDto.result.map((x) => StateDto.fromMap(x)));
  }

  static Future<List<CityDto>> getCities() async {
    String token = await TokenSecureStorage.readToken();
    String baseUrl = services.baseUrl;
    final header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final url = Uri.parse('$baseUrl/v1/api/city');
    final response = await http.get(url, headers: header);
    ResponseDto responseDto = ResponseDto.fromJson(response.body);
    if (response.statusCode != 200) {
      if (responseDto.statusCode == 'SCTY-2002') {
        await RefreshTokenService.refreshToken();
        return getCities();
      }
      throw BarkibuException(responseDto.statusCode);
    }
    return List<CityDto>.from(responseDto.result.map((x) => CityDto.fromMap(x)));
  }
}
