import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {

  final String uid;
  final String email;
  final String name;
  final String url;

  ChatRoom({this.uid, this.email, this.name, this.url});

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(

        ),
        body: Text("aaaaaaaaa"),
      ),
    );
  }
}
