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

  @override
  Widget build(BuildContext context) {

    final availableHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;

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
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: availableHeight,
              width: MediaQuery.of(context).size.width,
              color: Color(0xFF7294C2),
              child: Column(
                children: [
                  Container(
                    height: availableHeight - 50,
                  ),
                  Container(
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
                              SaveData().then((value){
                              }).catchError((onError){
                                print(onError);
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future SaveData() async {
      try{
        final doc = FirebaseFirestore.instance.collection("messages").doc();
        await doc.set(
          {
            'content': textController.text,
            'sender': 'ここにuidを入れる',
            'created_at': DateTime.now(),
          }
        );
        textController.text = "";
      } catch(e) {

      }
  }
}
