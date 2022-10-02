import 'package:barkibu/dto/dto.dart';

class RegisterUserService {
  static Future<RegisterUserResponseDto> registerUser(String username, String password) async {
    if (username == "jperez" && password == "123456") {
      return RegisterUserResponseDto(
        success: true,
      );
    } else if (username == "mgomez") {
      throw Exception("Error de comunicación con internet");
    } else {
      return RegisterUserResponseDto(success: false);
    }
  }
}
