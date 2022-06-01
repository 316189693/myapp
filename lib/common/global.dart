import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myapp/models/index.dart';
const _themes = <MaterialColor>[
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.red,
];
class Global {
  static SharedPreferences? _prefs;
  static Profile profile = Profile();
  static List<MaterialColor> get themes => _themes;
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");
  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
    var _profile = _prefs!.getString("profile");
    if(_profile != null) {
      try {
        profile = Profile.fromJson(jsonDecode(_profile));
      } catch(e) {
          if (!isRelease) {
            print(e);
          }
          }
    }  else {
      profile= Profile.fromJson({
        "theme": 5678,
        "locale": "en_US",
        "user": {
          "user_name": "",
          "first_name": "",
          "last_name": "",
          "email": "",
          "token": "",
          "user_id": 0
        },
        "lastLogin": ""
      });
    }
  }

  static saveProfile() => _prefs!.setString("profile", jsonEncode(profile.toJson()));
}