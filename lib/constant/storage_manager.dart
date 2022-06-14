import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static SharedPreferences? _preferences;
  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();
  static Future? setToken(String? token) async =>
      await _preferences!.setString(KeyName.jwtToken, token!);
  static String? getToken() => _preferences!.getString(KeyName.jwtToken);
  static Future? setUserId(int id) async =>
      await _preferences!.setInt(KeyName.id, id);
  static int? getUserId() => _preferences!.getInt(KeyName.id);
  static Future? setEmail(String? email) async =>
      await _preferences!.setString(KeyName.email, email!);
  static String? getEmail() => _preferences!.getString(KeyName.email);
  static Future? setName(String? name) async =>
      await _preferences!.setString(KeyName.name, name!);
  static String? getName() => _preferences!.getString(KeyName.name);
  static Future? setTheme(bool? theme) async =>
      await _preferences!.setBool(KeyName.theme, theme!);
  static bool? getTheme() => _preferences!.getBool(KeyName.theme);
  static Future? setLang(int? lang) async =>
      await _preferences!.setInt(KeyName.lang, lang!);
  static int? getLang() => _preferences!.getInt(KeyName.lang);
  static Future? setShippingCost(int? cost) async =>
      await _preferences!.setInt(KeyName.cost, cost!);
  static int? getShippingCost() => _preferences!.getInt(KeyName.cost);

  static logoutUser() {
    _preferences!.remove(KeyName.name);
    _preferences!.remove(KeyName.email);
    _preferences!.remove(KeyName.id);
    _preferences!.remove(KeyName.jwtToken);
  }
}

class KeyName {
  static const jwtToken = 'token';
  static const email = 'email';
  static const id = 'id';
  static const lang = 'lang';
  static const name = 'name';
  static const theme = "theme";
  static const cost = "cost";
}

class AppSession {
  static String? accessToken;
  static int? userId;
}
