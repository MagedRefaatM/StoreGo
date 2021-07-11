import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPref {
  read(String key) async {
    final _res = await SharedPreferences.getInstance();
    return json.decode(_res.getString(key));
  }

  save(String key, value) async {
    await SharedPreferences.getInstance().then((instance) {
      instance.setString(key, json.encode(value));
    });
  }

  remove(String key) async {
    await SharedPreferences.getInstance()
        .then((instance) => instance.remove(key));
  }
}
