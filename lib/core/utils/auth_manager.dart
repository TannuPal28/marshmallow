import 'package:shared_preferences/shared_preferences.dart';

class AuthManager {
  static const String tokenKey = "token"; // same key

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(tokenKey, token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(tokenKey);
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(tokenKey);
  }

  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
  }

  static Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  static Future<void> saveUserData({
    required String name,
    required String email,
  }) async {
    final prefs= await SharedPreferences.getInstance();

    await prefs.setString("user_name", name);
    await prefs.setString("user_email", email);
  }

  static Future<String> getUserName() async{
    final prefs= await SharedPreferences.getInstance();
    return prefs.getString("user_name") ?? "";
  }

  static Future<String> getUserEmail() async{
    final prefs= await SharedPreferences.getInstance();
    return prefs.getString("user_email") ?? "";
  }
}
