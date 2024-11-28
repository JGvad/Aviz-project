import 'package:aviz/Di/di.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthManagement {
  static final _secureStorage = locator.get<FlutterSecureStorage>();

  static Future<void> _save(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  static Future<void> saveToken(String token) async {
    await _save('Token', token);
  }

  static Future<void> saveUserId(String userId) async {
    await _save('userId', userId);
  }

  static Future<String?> _read(String key) async {
    return await _secureStorage.read(key: key);
  }

  static Future<String?> readToken() async {
    return await _read('Token');
  }

  static Future<String?> readUserId() async {
    return await _read('userId');
  }

  static Future<bool> isLogin() async {
    String? token = await _read('Token');
    return token != null;
  }

  static Future<void> logOut({String? key}) async {
    if (key != null) {
      await _secureStorage.delete(key: key);
    } else {
      await _secureStorage.deleteAll();
    }
  }

  static Future<bool> checkFirstTime() async {
    SharedPreferences prefs = locator.get<SharedPreferences>();

    bool? isFirstTime = prefs.getBool('isFirstTime');

    if (isFirstTime == null || isFirstTime) {
      await prefs.setBool('isFirstTime', false);
      return true;
    } else {
      return false;
    }
  }
}
