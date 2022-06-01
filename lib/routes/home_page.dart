import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myapp/common/funcs.dart';
import 'package:myapp/i10n/localization_intl.dart';
import 'package:myapp/models/index.dart';
import 'package:myapp/states/ProfileChangeNotifier.dart';
import 'package:myapp/widgets/user_item.dart';
import 'package:provider/provider.dart';

class HomeRoute extends StatefulWidget {
  const HomeRoute({Key? key}) : super(key: key);

  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static const loadingTag = "####loading#####";
  var _items = <User>[User()..user_name = loadingTag];
  bool hasMore = true;
  int page = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(GmLocalizations.of(context)!.home),
      ),
      body: _buildBody(),
      drawer: MyDrawer(),
    );
  }

  Widget _buildBody() {
    UserModel userModel = Provider.of<UserModel>(context);
    if (!userModel.isLogin) {
      // 未登录， 显示登录按钮
      return Center(
          child: ElevatedButton(
        child: Text(GmLocalizations.of(context)!.login),
        onPressed: () => Navigator.of(context).pushNamed("login"),
      ));
    } else {
      return ListView.separated(
          itemBuilder: (context, index) {
            if (_items[index].user_name == loadingTag) {
              if (hasMore) {
                _retriveData(userModel.user!.token, userModel.user!.user_id);
                return Container(
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 24.0,
                    height: 24.0,
                    child: CircularProgressIndicator(strokeWidth: 2.0),
                  ),
                );
              } else {
                return Container(
                    padding: const EdgeInsets.all(16.0),
                    alignment: Alignment.center,
                    child: Text(
                      GmLocalizations.of(context)!.notAnyMore,
                      style: TextStyle(color: Colors.grey),
                    ));
              }
            }
            return UserItem(user: _items[index]);
          },
          separatorBuilder: (context, index) => Divider(height: 0),
          itemCount: _items.length);
    }
  }

  void _retriveData(token, user_id) async {
    try {
      var dio = new Dio();
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        //校验证书
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) {
          return true;
        };
      };
      var response = await dio.get(
          'https://42.192.226.123:7000/htjy/api/user/list?UserToken=$token&UserID=$user_id');
      if (response.data != null) {
        setState(() {
          //重新构建列表
          List<User> _items1 = [];
          for (var item in response.data['data']) {
            User user = User()..user_name = item['user_username'];
            _items1.add(user);
          }
          _items = _items1;
          hasMore = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    child:
    return Drawer(
        child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _builderHeader(),
                Expanded(child: _buildMenus()),
              ],
            )));
  }

  Widget _builderHeader() {
    return Consumer<UserModel>(
        builder: (BuildContext context, UserModel userModel, Widget? widget) {
      return GestureDetector(
        child: Container(
          color: Theme.of(context).primaryColor,
          padding: EdgeInsets.only(top: 40, bottom: 20),
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: ClipOval(
                  child: userModel.isLogin
                      ? gmAvatar(
                          'https://files2.fr8taxi.com/uploader/files/2022/05/31/%E5%BE%AE%E4%BF%A1%E5%9B%BE%E7%89%87_20211201181146___8_.jpg',
                          width: 80)
                      : Image.asset("assets/images/tfz.jpg", width: 80),
                ),
              ),
              Text(
                  userModel.isLogin
                      ? userModel.user!.user_name
                      : GmLocalizations.of(context)!.userName,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white))
            ],
          ),
        ),
        onTap: () {
          if (!userModel.isLogin) Navigator.of(context).pushNamed("login");
        },
      );
    });
  }

  Widget _buildMenus() {
    return Consumer<UserModel>(
        builder: (BuildContext context, UserModel usermodel, Widget? child) {
      var gm = GmLocalizations.of(context);
      return ListView(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: Text(gm!.theme),
            onTap: () => Navigator.pushNamed(context, 'themes'),
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(gm.language),
            onTap: () => Navigator.pushNamed(context, 'language'),
          ),
          if (usermodel.isLogin)
            ListTile(
              leading: const Icon(Icons.power_settings_new),
              title: Text(gm.logout),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                          content: Text(gm.logoutTip),
                          actions: <Widget>[
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(gm.cancel)),
                            TextButton(
                                onPressed: () {
                                  usermodel.user = null;
                                  Scaffold.of(context).closeDrawer();
                                  Navigator.pop(context);
                                },
                                child: Text(gm.yes)),
                          ]);
                    });
              },
            ),
        ],
      );
    });
  }
}
