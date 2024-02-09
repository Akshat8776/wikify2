import 'dart:async' show Future;
import 'package:blocimplement/enums/theme.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../global/global.dart';

class PreferenceUtils {
  static Future<SharedPreferences> get _instance async {
    if (_prefsInstance == null) {
      _prefsInstance = await SharedPreferences.getInstance();
      cacheDirectory = (await getTemporaryDirectory()).path;
      getLang();
      getTheme();
    }
    return _prefsInstance!;
  }

  static SharedPreferences? _prefsInstance;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance!;
  }

  // static String getString(String key, String defValue) {
  //   return _prefsInstance?.getString(key) ?? defValue ?? "";
  // }
  //
  // static Future<bool> setString(String key, String value) async {
  //   var prefs = await _instance;
  //   return prefs.setString(key, value) ?? Future.value(false);
  // }

  static Future<void> getTheme() async {
    var prefs = await _instance;
    String? theme = prefs.getString('theme');
    if (theme == null) {
      prefs.setString('theme', 'LIGHT');
      globaltheme.value = Themes.LIGHT;
    } else {
      globaltheme.value = theme == "LIGHT" ? Themes.LIGHT : Themes.DARK;
    }
    col.value = globaltheme.value == Themes.LIGHT ? Colors.white : Colors.black;
  }

  static Future<void> getLang() async {
    var prefs = await _instance;
    String? languagepref = prefs.getString('lang');
    if (languagepref == null) {
      prefs.setString('lang', 'en');
    } else {
      lang.value = languagepref;
    }
  }

  static Future<List<String>?> getCacheList() async {
    var prefs = await _instance;
    List<String>? listString = prefs.getStringList('list');
    return listString;
  }

  static Future<void> setLang() async {
    var prefs = await _instance;
    String? languagepref = prefs.getString('lang');
    if (languagepref == null) {
      prefs.setString('lang', 'en');
    } else {
      lang.value = languagepref;
    }
  }

  static Future<void> setCacheList(List<String> list) async {
    var prefs = await _instance;
    await prefs.setStringList('list', list);
  }

  static Future<void> removeAllCache() async {
    var prefs = await _instance;
    prefs.remove('list');
  }

  static void saveLang(String lang) async {
    var prefs = await _instance;
    await prefs.setString('lang', lang);
  }

  static Future<void> saveTheme(String theme) async {
    var prefs = await _instance;
    await prefs.setString('theme', theme);
  }
}
