import 'package:barkibu/dto/dto.dart';

class RegisterPetService {
  static Future<RegisterPetResponseDto> registerPet(String name) async {
    if (name == 'Trueno') {
      return RegisterPetResponseDto(
        success: true,
      );
    } else if (name == "Toby") {
      throw Exception("Error de comunicación con internet");
    } else {
      return RegisterPetResponseDto(success: false);
    }
  }
}
