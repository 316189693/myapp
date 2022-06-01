import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myapp/common/global.dart';
import 'package:myapp/models/index.dart';

class ProfileChangeNotifier extends ChangeNotifier{
    Profile get _profile => Global.profile;

    @override
    void notifyListeners(){
      Global.saveProfile();
      super.notifyListeners();
    }
}

class ThemeModel extends ProfileChangeNotifier {
   MaterialColor get theme => Global.themes.firstWhere((e) =>  e.value == _profile.theme, orElse: ()=>Colors.blue);
   set theme(MaterialColor color) {
     if (color != theme) {
       _profile.theme = color[500]!.value;
       notifyListeners();
     }
   }
}

class UserModel extends ProfileChangeNotifier{
  User? get user => _profile.user;
  // APP是否登录(如果有用户信息，则证明登录过)
  bool get isLogin => user != null;

  //用户信息发生变化，更新用户信息并通知依赖它的子孙Widgets更新
  set user(User? user) {
    if(user?.user_name != _profile.user?.user_name) {
      _profile.lastLogin = _profile.user != null ? _profile.user!.user_name : "";
      _profile.user = user;
      notifyListeners();
    }
  }
}
class LocaleModel extends ProfileChangeNotifier{
  // 获取当前用户的APP语言配置Locale类，如果为null，则语言跟随系统语言
  Locale getLocale() {
    if (_profile.locale != null) {
      var t = _profile.locale.split("_");
      return Locale(t[0], t[1]);
    }
    return Locale('en');
  }

  // 获取当前Locale的字符串表示
  String get locale => _profile.locale;

  // 用户改变APP语言后，通知依赖项更新，新语言会立即生效
  set locale(String locale) {
    if (locale != _profile.locale) {
      _profile.locale = locale;
      notifyListeners();
    }
  }
}