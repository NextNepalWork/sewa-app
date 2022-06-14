class ValidatorManager {
  static String? validateEmpty(String? input) {
    String? message;
    if (input!.isEmpty) {
      message = "This field is required";
    }
    return message;
  }

  static String? validatePassword(String? input) {
    String? message;
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = RegExp(pattern);
    if (input!.isEmpty) {
      message = "This field is required";
    } else if (!regex.hasMatch(input)) {
      message =
          "Password should have at least one upper case,\none digit,special char and 8 digit long";
    }
    return message;
  }
}
