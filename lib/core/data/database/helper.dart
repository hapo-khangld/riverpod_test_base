import 'package:riverpod_test_base/core/data/database/shared_preferences_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Helper {

  static Future<void> initLibrary() async {
    await Future.wait([
      _sharedPrefManager(),
    ]);
  }

  static Future<void> _sharedPrefManager() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    SharedPrefManager(sharedPreferences: pref);
  }
}