import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lize/views/chat_room.dart';

class FriendPage extends StatefulWidget {

  final String friendName;
  final String friendUrl;
  final String friendUid;
  final String uid;

  FriendPage({this.friendUid, this.friendName, this.friendUrl, this.uid});

  @override
  _FriendPageState createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Container(
            decoration: BoxDecoration(
                boxShadow: [
                  _boxShadow()
                ]
            ),
            child: Icon(Icons.close),
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                color: Colors.white.withOpacity(0.4),
                boxShadow: [
                  _boxShadow()
                ]
              ),
              child: Icon(Icons.card_giftcard, size: 20,),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                color: Colors.white.withOpacity(0.4),
                boxShadow: [
                  _boxShadow()
                ]
              ),
              child: Icon(Icons.star_border, size: 20,),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                color: Colors.white.withOpacity(0.4),
                boxShadow: [
                  _boxShadow()
                ]
              ),
              child: Icon(Icons.more_horiz, size: 20,),
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.png'),
            fit: BoxFit.cover
          )
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 9,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.width * 0.3,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(widget.friendUrl),
                              fit: BoxFit.cover
                          ),
                          shape: BoxShape.circle,
                          boxShadow: [
                            _boxShadow()
                          ]
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        widget.friendName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.3),
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(child: SizedBox(), flex: 2,),
              Expanded(
                flex: 4,
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              child: Container(
                                child: Column(
                                  children: [
                                    Container(
                                      child: Icon(
                                        Icons.message,
                                        size: 40,
                                        color: Colors.white,
                                      ),
                                      decoration: BoxDecoration(boxShadow: [_boxShadow()]),
                                    ),
                                    Text(
                                      'トーク',
                                      style: TextStyle(
                                        color: Colors.white,
                                        shadows: [
                                          Shadow(
                                            blurRadius: 10,
                                            color: Colors.black.withOpacity(0.3),
                                            offset: Offset(1, 1),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              onTap: (){
                                searchChatRoom();
                              },
                            ),
                            GestureDetector(
                              child: Container(
                                child: Column(
                                  children: [
                                    Container(
                                      child: Icon(
                                        Icons.phone_in_talk,
                                        size: 40,
                                        color: Colors.white,
                                      ),
                                      decoration: BoxDecoration(boxShadow: [_boxShadow()]),
                                    ),
                                    Text(
                                      '音声通話',
                                      style: TextStyle(
                                        color: Colors.white,
                                        shadows: [
                                          Shadow(
                                            blurRadius: 10,
                                            color: Colors.black.withOpacity(0.3),
                                            offset: Offset(1, 1),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              onTap: (){},
                            ),
                            GestureDetector(
                              child: Container(
                                child: Column(
                                  children: [
                                    Container(
                                      child: Icon(
                                        Icons.video_call,
                                        size: 40,
                                        color: Colors.white,
                                      ),
                                      decoration: BoxDecoration(boxShadow: [_boxShadow()]),
                                    ),
                                    Text(
                                      'ビデオ通話',
                                      style: TextStyle(
                                        color: Colors.white,
                                        shadows: [
                                          Shadow(
                                            blurRadius: 10,
                                            color: Colors.black.withOpacity(0.3),
                                            offset: Offset(1, 1),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              onTap: (){},
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Container(
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: (){
                                print("投稿");
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "投稿",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 10,
                                        color: Colors.black.withOpacity(0.3),
                                        offset: Offset(1, 1),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                print("写真・動画");
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "写真・動画",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 10,
                                        color: Colors.black.withOpacity(0.3),
                                        offset: Offset(1, 1),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future searchChatRoom() async {
    try {
      final rooms = FirebaseFirestore.instance.collection("rooms");
      final room = rooms.where('${widget.uid}', isEqualTo: 'member').where('${widget.friendUid}', isEqualTo: 'member');
      room.get().then((value){
        final searchedRoom = value.docs.first;
        final roomId = searchedRoom.id;
        Navigator.pushReplacement(
            context,
            CupertinoPageRoute(
                builder: (BuildContext context) =>
                    ChatRoom(
                      roomId: roomId,
                      uid: widget.uid,
                      friendUid: widget.friendUid,
                      friendName: widget.friendName,
                      friendUrl: widget.friendUrl,
                    )
            )
        );
      }).catchError((onError){
        print(onError);
        addChatRoom();
      });
    } catch (e) {
      print(e);
    }
  }

  Future addChatRoom() async {
    try {
      final doc = FirebaseFirestore.instance.collection("rooms").doc();
      final roomId = doc.id;
      print("新規ルーム：$roomId");
      await doc.set(
          {
            'room_name': null,
            '${widget.uid}': "member",
            '${widget.friendUid}': "member",
            'member': [widget.uid, widget.friendUid],
            'created_at': DateTime.now(),
          }
      );
      Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
              builder: (BuildContext context) =>
                  ChatRoom(
                    roomId: roomId,
                    uid: widget.uid,
                    friendUid: widget.friendUid,
                    friendName: widget.friendName,
                    friendUrl: widget.friendUrl,
                  )
          )
      );
    } catch (e) {
      print(e);
    }
  }

  _boxShadow(){
    return BoxShadow(
      color: Colors.black.withOpacity(0.1),
      spreadRadius: 1,
      blurRadius: 15,
      offset: Offset(0, 0),
    );
  }
}
