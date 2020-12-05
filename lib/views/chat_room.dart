import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {

  final textController = TextEditingController();

  final scroll = ScrollController();

  final messages = FirebaseFirestore.instance.collection('messages');

  @override
  Widget build(BuildContext context) {

    final availableHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;

    var bottomSpace = MediaQuery.of(context).viewInsets.bottom;

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
      body: SafeArea(
        child: Stack(
          children: [
            GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Container(
                color: Color(0xFF7294C2),
                child: ChatContents(availableHeight, bottomSpace)
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: 50,
                color: Colors.white,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.125,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.add_box, color: Color(0xFF202B42),),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      height: 40,
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]),
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: textController,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "メッセージを入力",
                                  hintStyle: TextStyle(fontSize: 14, color: Colors.grey[400], height: 3)
                              ),
                              style: TextStyle(
                                  fontSize: 14
                              ),
                            ),
                            flex: 6,
                          ),
                          Expanded(
                            child: GestureDetector(
                              child: Icon(Icons.tag_faces, color: Color(0xFF202B42)),
                              onTap: (){
                                //ToDo ボタンを押したら表示を変える
                              },
                            ),
                            flex: 1,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.125,
                      child: GestureDetector(
                        child: Icon(Icons.send, color: Color(0xFF5173FF)),
                        onTap: (){
                          if(!(textController.text == '')){
                            SaveData(availableHeight, bottomSpace).then((value){
                              textController.text = "";
                              scroll.animateTo(
                                0,
                                duration: Duration(milliseconds: 10000),
                                curve: Curves.easeIn
                              );
                            }).catchError((onError) {
                              print(onError);
                            });
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future SaveData(availableHeight, bottomSpace) async {
    try {
      final doc = FirebaseFirestore.instance.collection("messages").doc();
      await doc.set(
          {
            'content': textController.text,
            'sender': 'ここにuidを入れる',
            'created_at': DateTime.now(),
          }
      );
    } catch (e) {

    }
  }

  Widget ChatContents(availableHeight, bottomSpace){

    return Column(
      children: [
        Container(
          // height: availableHeight,
          // padding: EdgeInsets.only(bottom: bottomSpace + 50),
          height: availableHeight - (bottomSpace + 50),
          width: MediaQuery.of(context).size.width,
          child: StreamBuilder<QuerySnapshot>(
            stream: messages.orderBy('created_at', descending: true).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List<DocumentSnapshot> documents = snapshot.data.docs;
                return ListView(
                  reverse: true,
                  controller: scroll,
                  children: documents.map((document) {
                    return Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(right: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '既読',
                                    style: TextStyle(
                                      fontSize: 12
                                    ),
                                  ),
                                  convertDateTime(document['created_at']),
                                  // Text(
                                  //     document['created_at'].toDate().toString()
                                  // ),
                                ],
                              ),
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width * 0.60,
                              ),
                              child: Container(
                                margin: EdgeInsets.only(top: 0, bottom: 5),
                                padding: EdgeInsets.fromLTRB(12, 10, 12, 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  color: Color(0xFF70DE53)
                                ),
                                child: Text(document['content'],textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 15
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              }
              return Center(
                child: Text("読み込み中..."),
              );
            }
          ),
        )
      ],
    );
  }

  Widget convertDateTime(createdAt){

    var date = DateTime.parse(createdAt.toDate().toString());
    var formattedHour = date.hour.toString();
    var formattedMin = date.minute.toString();

    if(!(RegExp(r'^\d{2}$').hasMatch(formattedMin))){
      var dateTime = formattedHour + ":0" + formattedMin;
      return Text(dateTime);
    } else {
      var dateTime = formattedHour + ":" + formattedMin;
      return Text(dateTime);
    }
  }
}
