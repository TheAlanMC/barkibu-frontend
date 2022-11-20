import 'package:http/http.dart' as http;

class Validator {
  static Future<String?> validatePhotoPath(String photoPath) async {
    RegExp exp = RegExp(r'^(http(s?):)([/|.|\w|\s|-])*\.(?:jpg|gif|png)');
    if (!exp.hasMatch(photoPath)) {
      return null;
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
}
