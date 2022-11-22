class TextUtil {
  static String toUpperCaseFirstLetter(String text) {
    return text[0].toUpperCase() + text.substring(1);
  }

  static String yesOrNo(bool value) {
    return value ? 'Si' : 'No';
  }

  static String list(List<String> list) {
    String result = '';
    for (String item in list) {
      result += '$item, ';
    }
    return toUpperCaseFirstLetter(result.substring(0, result.length - 2));
  }
}
