import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const String _keyIsLoggedIn = 'isLoggedIn';
  static const String _keyLoggedInEmail = 'loggedInEmail';
  static const String _keyLoggedInUserId = 'loggedInUserId';

  static Future<bool> saveLoginSession({
    required String useremail,
    required String userId,
  }) async {
    try {
      final sp = await SharedPreferences.getInstance();
      await sp.setBool(_keyIsLoggedIn, true);
      await sp.setString(_keyLoggedInEmail, useremail);
      await sp.setString(_keyLoggedInUserId, userId);
      return true;
    } catch (e) {
      log('Error saving login session: $e');
      return false;
    }
  }

  static Future<String?> getLoggedInEmail() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getString(_keyLoggedInEmail);
  }

  static Future<String?> getLoggedInUserId() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getString(_keyLoggedInUserId);
  }

  static Future<bool> isLoggedIn() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getBool(_keyIsLoggedIn) ?? false;
  }

  static Future<void> clearSession() async {
    final sp = await SharedPreferences.getInstance();
    await sp.remove(_keyIsLoggedIn);
    await sp.remove(_keyLoggedInEmail);
    await sp.remove(_keyLoggedInUserId);
  }
}
