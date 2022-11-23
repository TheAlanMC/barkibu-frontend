import 'package:http/http.dart' as http;

class ValidatorUtil {
  static Future<String?> validatePhotoPath(String photoPath) async {
    RegExp exp = RegExp(r'^(http(s?):)([/|.|\w|\s|-])*\.(?:jpg|gif|png)');

    if (!exp.hasMatch(photoPath)) {
      return '';
    }
    try {
      final response = await http.get(Uri.parse(photoPath));
      if (response.statusCode != 200) {
        return null;
      }
    } catch (e) {
      return null;
    }
    return photoPath;
  }

  static bool validateEmail(String email) {
    RegExp exp = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    return exp.hasMatch(email);
  }

  static bool validatePassword(String password) {
    RegExp exp = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$');
    return exp.hasMatch(password);
  }
}
