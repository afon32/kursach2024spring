// ignore_for_file: avoid_print

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class DataKeys {
  static const hiveBox = 'mybox';
  static const sessionId = 'sessionId';
  static const profileId = 'profileId';
}

// сохранение токена и получение из шифрованной памяти
class SessionDataProvider {
  // получение токена из памяти
  Future<String?> getSessionId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final sessionId = prefs.getString(DataKeys.sessionId);

    return sessionId;
  }

  setSessionId({required String value}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (kDebugMode) {
      print('Сохранение токена в кэш: $value');
    }

    await prefs.setString(DataKeys.sessionId, value);
  }

  deleteSessionId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (kDebugMode) {
      print('Очистка сессии');
    }

    await prefs.remove(DataKeys.sessionId);
  }
}
