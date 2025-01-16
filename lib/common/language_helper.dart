import 'package:shared_preferences/shared_preferences.dart';

class LanguageHelper {
  static const languages = [
    {'name': 'English', 'code': 'en'},
    {'name': 'German', 'code': 'de'},
  ];

  static const String _languageKey = 'selected_language';

  // Save selected language to SharedPreferences
  static Future<void> saveLanguage(String languageCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, languageCode);
  }

  // Get selected language from SharedPreferences
  static Future<String> getSavedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_languageKey) ?? 'en'; // Default to 'en'
  }
}
