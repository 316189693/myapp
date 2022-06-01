import 'package:flutter/material.dart';
import 'package:myapp/common/funcs.dart';
import 'package:myapp/common/icons.dart';
import 'package:myapp/models/index.dart';

class UserItem extends StatefulWidget {
  const UserItem({Key? key, required User this.user}) : super(key: key);
  final User user;

  @override
  _UserItemState createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  @override
  Widget build(BuildContext context) {
    var subTitle;
    return Padding(padding: const EdgeInsets.only(top: 8),
      child: Material(
        color: Colors.white,
        shape: BorderDirectional(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
            width: .5,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: .0, bottom:16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTile(
                dense: true,
                leading: gmAvatar("https://files2.fr8taxi.com/uploader/files/2022/05/31/%E5%BE%AE%E4%BF%A1%E5%9B%BE%E7%89%87_20211201181146___8_.jpg",
                width: 24.0,
                borderRadius: BorderRadius.circular(12)
                ),
                title: Text(
                  widget.user.user_name,
                  textScaleFactor: 9,
                ),
                subtitle: subTitle,
                trailing: Text("ddd"),

              ),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("fork",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top:8, bottom: 12),
                     child: Text(
                       "descffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff",
                       maxLines: 3,
                       style: TextStyle(
                         height: 1.15,
                         color: Colors.blueGrey[700],
                         fontSize: 13
                       ),
                     ),
                    )
                  ],
                ),
              ),
              _buildBottom()
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildBottom(){
     const paddingWidth = 10;
     return IconTheme(data: IconThemeData(
       color: Colors.grey,
       size: 15
     ), child: DefaultTextStyle(
       style: TextStyle(color: Colors.grey, fontSize: 12),
       child: Padding(
         padding: const EdgeInsets.symmetric(horizontal: 16),
         child: Builder(
           builder: (context) {
             var children = <Widget> [
               Icon(Icons.star),
               Text(" 10"),
               Icon(Icons.info_outline),
               Text(" issue count"),
               Icon(MyIcons.fork),
               Text(" forks_count")

             ];
             return Row(children: children);
           },
         ),
       ),
     ));
  }
}