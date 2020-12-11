import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';

class ChatRoom extends StatefulWidget {

  final String roomId;
  final String uid;
  final String friendUid;
  final String friendName;
  final String friendUrl;
  final String lastMessage;

  ChatRoom({this.roomId, this.uid, this.friendUid, this.friendName, this.friendUrl, this.lastMessage});

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {

  final textController = TextEditingController();

  final scroll = ScrollController();

  final messages = FirebaseFirestore.instance.collection('messages');

  var lastMessageDate;

  var firstMessageDate;

  DateTime createdAt;

  final yesterday = new DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day -1);

  final now = new DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  var _weekName =  ['月', '火', '水', '木', '金', '土', '日'];

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
        title: Text(widget.friendName),
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
                child: chatContents(availableHeight, bottomSpace)
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
                            saveData(availableHeight, bottomSpace).then((value){
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

  Future saveData(availableHeight, bottomSpace) async {
    try {

      final doc = FirebaseFirestore.instance.collection("messages").doc();
      if(!(lastMessageDate == now)){
        await doc.set(
            {
              'day_first': true,
              'room_id': widget.roomId,
              'content': textController.text,
              'sender': widget.uid,
              'created_at': DateTime.now(),
            }
        );
      } else {
        await doc.set(
            {
              'day_first': false,
              'room_id': widget.roomId,
              'content': textController.text,
              'sender': widget.uid,
              'created_at': DateTime.now(),
            }
        );
      }
    } catch (e) {
      print(e);
    }
  }

  Widget chatContents(availableHeight, bottomSpace){

    return Container(
      height: availableHeight - bottomSpace,
      padding: EdgeInsets.only(top: 5, bottom: 50),
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder<QuerySnapshot>(
        stream: messages.where('room_id', isEqualTo: widget.roomId).orderBy('created_at', descending: false).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<DocumentSnapshot> documents = snapshot.data.docs;
            try{
              var createdAt = documents.last['created_at'].toDate();
              lastMessageDate = new DateTime(createdAt.year, createdAt.month, createdAt.day);
            } catch(e) {
              print(e);
            }
            return ListView(
              controller: scroll,
              children: documents.map((document) {
                if(document['sender'] == widget.uid){
                  return Column(
                    children: [
                      _createdDateWidget(document, createdAt),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(left: 5, right: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              padding: EdgeInsets.only(right: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '既読',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white
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
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      _createdDateWidget(document, createdAt),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(left: 5, right: 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(widget.friendUrl),
                                      fit: BoxFit.cover
                                    ),
                                    shape: BoxShape.circle
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(left: 7),
                                      child: Text(
                                        widget.friendName,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 3,),
                                    ConstrainedBox(
                                      constraints: BoxConstraints(
                                        maxWidth: MediaQuery.of(context).size.width * 0.60,
                                      ),
                                      child: Container(
                                        margin: EdgeInsets.only(top: 0, bottom: 5, left: 3),
                                        padding: EdgeInsets.fromLTRB(12, 10, 12, 10),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(20)),
                                            color: Colors.white
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
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(5, 0, 5, 10),
                              child: convertDateTime(document['created_at']),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              }).toList(),
            );
          }
          return Center(
            child: Text("読み込み中..."),
          );
        }
      ),
    );
  }

  Widget _createdDateWidget(document, createdAt){
    if(document['day_first'] == true){
      final createdAtFirst = document['created_at'].toDate();
      return Container(
        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
        margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.black.withOpacity(0.1)
        ),
        child: Text(
          _createDate(createdAtFirst),
          style: TextStyle(
            color: Colors.white,
            fontSize: 13
          ),
        ),
      );
    }
    return Container();
  }

  _createDate(createdAtFirst){

    final createdAtFirstOfYesterday = DateTime(createdAtFirst.year, createdAtFirst.month, createdAtFirst.day).toString();

    if(lastMessageDate.year == createdAtFirst.year){ //今年のメッセージの場合
      if("${lastMessageDate.month}${lastMessageDate.day}" == "${createdAtFirst.month}${createdAtFirst.day}"){ // 今日のメッセージの場合
        firstMessageDate = "今日";
        return firstMessageDate;
      } else { //今日のメッセージではない場合
        if(createdAtFirstOfYesterday.toString() == yesterday.toString()){ //昨日のメッセージの場合
          firstMessageDate = "昨日";
          return firstMessageDate;
        } else { //昨日のメッセージではない場合
          firstMessageDate = "${createdAtFirst.month}/${createdAtFirst.day}(${_weekName[createdAtFirst.weekday - 1]})";
          return firstMessageDate;
        }
      }
    } else { //今年のメッセージではない場合
      firstMessageDate = "${createdAtFirst.year}年${createdAtFirst.month}月${createdAtFirst.day}日(${_weekName[createdAtFirst.weekday - 1]})";
      return firstMessageDate;
    }
  }

  Widget convertDateTime(createdAt){

    var date = DateTime.parse(createdAt.toDate().toString());
    var formattedHour = date.hour.toString();
    var formattedMin = date.minute.toString();

    if(!(RegExp(r'^\d{2}$').hasMatch(formattedMin))){
      var dateTime = formattedHour + ":0" + formattedMin;
      return Text(dateTime, style: TextStyle(color: Colors.white, fontSize: 12),);
    } else {
      var dateTime = formattedHour + ":" + formattedMin;
      return Text(dateTime, style: TextStyle(color: Colors.white, fontSize: 12),);
    }
  }
}
