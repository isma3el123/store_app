import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static final SharedPreferencesHelper _instance =
      SharedPreferencesHelper._internal();

  factory SharedPreferencesHelper() {
    return _instance;
  }

  SharedPreferencesHelper._internal();

  // حفظ التوكين
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  // استرجاع التوكين
  static Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token') ?? '';
  }

  // إزالة التوكين
  Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }

  // حفظ كلمة المرور
  Future<void> savePassword(String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_password', password);
  }

  // استرجاع كلمة المرور
  static Future<String> getPassword() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_password') ?? '';
  }

  // إزالة كلمة المرور
  Future<void> removePassword() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_password');
  }
}
