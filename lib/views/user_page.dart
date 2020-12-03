import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:lize/views/talk_page.dart';
import 'package:lize/views/home_page.dart';

class UserPage extends StatefulWidget {

  final String uid;
  final String email;
  final String name;
  final String url;
  final bool complete;

  UserPage({this.uid, this.email, this.name, this.url, this.complete});

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  @override
  Widget build(BuildContext context) {
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
              return Scaffold(
                appBar: AppBar(),
              );
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






