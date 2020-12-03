import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF202B42),
        elevation: 0,
        title: Text("友達"),
        centerTitle: false,
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.bookmark_border),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Color(0xFF7294C2),
        child: Column(
          children: [
            Container(),
            Container(
              height: 50,
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.add),
                        Icon(Icons.camera_alt_outlined),
                        Icon(Icons.image_outlined),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 40,
                    padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]),
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "メッセージを入力",
                              hintStyle: TextStyle(fontSize: 13, color: Colors.grey[400])
                            ),
                          ),
                          flex: 6,
                        ),
                        Expanded(
                          child: Icon(Icons.tag_faces),
                          flex: 1,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: Icon(Icons.mic_none),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
