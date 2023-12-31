import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  read(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(key)) {
      String? res = json.decode(prefs.getString(key) ?? "");

      return res;
    } else {
      return null;
    }
  }

  write(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(key, json.encode(value));
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  clear() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}

final sharedPref = SharedPref();
