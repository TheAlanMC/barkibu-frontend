import 'package:barkibu/dto/dto.dart';

class LoginService {
  static Future<LoginResponseDto> login(String username, String password) async {
    if (username == "jperez" && password == "123456") {
      return LoginResponseDto(
        success: true,
        token: "ey123hg123h123.12h323.adasd",
        refreshToken: "ey123hg123h123.12h323.adasd",
      );
    } else if (username == "mgomez") {
      throw Exception("Error de comunicación con internet");
    } else {
      return LoginResponseDto(success: false);
    }
  }
}
