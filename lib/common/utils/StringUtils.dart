class StringUtils {
  static String Trim(String str, List<String> chars) {
    bool end = false;

    var filteredChars = chars.where((x) => x != null && x.length > 0);

    while (!end) {
      end = true;
      for (String char in filteredChars) {
        if (str.length > 0) {
          if (str.startsWith(char)) {
            str = str.substring(char.length);
            end = false;
          }

          if (str.endsWith(char)) {
            str = str.substring(0, str.length - char.length);
            end = false;
          }
        }
      }
    }
    return str;
  }
}
