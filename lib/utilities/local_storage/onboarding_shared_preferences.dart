import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String _onboardingCompletedKey = 'onboarding_completed';

  static Future<bool> isOnboardingCompleted() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingCompletedKey) ?? false;
  }

  static Future<void> setOnboardingCompleted(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_onboardingCompletedKey, value);
  }
}