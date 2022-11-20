import 'package:barkibu/dto/dto.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:barkibu/services/services.dart' as services;

class RefreshTokenService {
  static Future<void> refreshToken() async {
    String refreshToken = await TokenSecureStorage.readRefreshToken();
    String baseUrl = services.baseUrl;
    final header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $refreshToken',
    };
    final url = Uri.parse('$baseUrl/v1/api/auth/refresh-token');
    final response = await http.post(url, headers: header);
    ResponseDto responseDto = ResponseDto.fromJson(response.body);
    if (response.statusCode != 200) {
      // Borramos el token y el refresh token
      await TokenSecureStorage.deleteTokens();
      throw BarkibuException(responseDto.statusCode);
    }
    LoginResponseDto loginResponseDto = LoginResponseDto.fromMap(responseDto.result);
    await TokenSecureStorage.saveToken(loginResponseDto.token, loginResponseDto.refreshToken);
  }
}
