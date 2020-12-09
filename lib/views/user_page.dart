import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:lize/views/news_page.dart';
import 'package:lize/views/talk_page.dart';
import 'package:lize/views/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPage extends StatefulWidget {

  final String uid;
  final String email;
  final String name;
  final String url;
  final bool firstLog;

  UserPage({this.uid, this.email, this.name, this.url, this.firstLog});

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  void setData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_uid', widget.uid);
    prefs.setString('user_name', widget.name);
    prefs.setString('user_url', widget.url);
  }

  @override
  Widget build(BuildContext context) {

    if(widget.firstLog == true){
      setData();
    }

    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          iconSize: 25,
          activeColor: Color(0xFF202B42),
          inactiveColor: Color(0xFFB9B8B9),
          items: [
            BottomNavigationBarItem(
              label: "ホーム",
              icon: Icon(Icons.home_filled,),
            ),
            BottomNavigationBarItem(
              label: "トーク",
              icon: Icon(Icons.message_outlined),
            ),
            BottomNavigationBarItem(
              label: "タイムライン",
              icon: Icon(Icons.access_time),
            ),
            BottomNavigationBarItem(
              label: "ニュース",
              icon: Icon(Icons.my_library_books_outlined),
            ),
            BottomNavigationBarItem(
              label: "ウォレット",
              icon: Icon(Icons.credit_card_rounded),
            ),
          ],
        ),
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return HomePage();
            case 1:
              return TalkPage();
            case 2:
              return Scaffold(
                appBar: AppBar(),
              );
            case 3:
              return NewsPage();
            case 4:
              return Scaffold(
                appBar: AppBar(),
              );
          }
          return null;
        }
    );
  }
}






