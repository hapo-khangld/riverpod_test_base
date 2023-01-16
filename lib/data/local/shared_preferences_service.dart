import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test_base/core/data/database/shared_preferences_manager.dart';

final sharedPrefServiceProvider = Provider(
  (_) => SharedPreferencesService(SharedPrefManager.instance),
);

class SharedPreferencesService {
  //
  final SharedPrefManager _sharedPrefManager;

  SharedPreferencesService(this._sharedPrefManager);

  Future<void> removeAll() async => _sharedPrefManager.removeAllData();

  // Theme
  String? get theme {
    return _sharedPrefManager.getData<String>(SharePreferenceKey.theme) as String;
  }

  Future<bool> saveTheme(ThemeMode mode) => _sharedPrefManager.setData(SharePreferenceKey.theme, mode.toString());

  //

  // Auth
  String? get authToken {
    final token = _sharedPrefManager.getData<String>(SharePreferenceKey.authToken);
    if (token != null) {
      return token as String;
    } else {
      return null;
    }
  }

  Future<bool> saveAuthToken(String authToken) async {
    return _sharedPrefManager.setData(SharePreferenceKey.authToken, authToken);
  }

  String? get refreshToken {
    final token = _sharedPrefManager.getData<String>(SharePreferenceKey.refreshToken);
    if (token != null) {
      return token as String;
    } else {
      return null;
    }
  }

  Future<bool> saveRefreshToken(String refreshToken) async {
    return _sharedPrefManager.setData(SharePreferenceKey.refreshToken, refreshToken);
  }

  bool get isSignIn => authToken != null ? true : false;
}

abstract class SharePreferenceKey {
  static const String theme = 'theme';
  static const String authToken = "authToken";
  static const String refreshToken = "refreshToken";
}
