import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static Future<SharedPreferences> get _instance async =>
      prefs ??= await SharedPreferences.getInstance();
  static SharedPreferences? prefs;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences> init() async {
    prefs = await _instance;
    return prefs ?? await SharedPreferences.getInstance();
  }

  static String? getMeterId() {
    return prefs?.getString('meterId');
  }

  static Future<void> setMeterId(String handwashId) async {
    await prefs?.setString('meterId', handwashId);
  }

  static Future<void> clear() async {
    await prefs?.clear();
  }
}
