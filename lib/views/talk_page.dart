import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lize/views/chat_room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class TalkPage extends StatefulWidget {

  final String uid;
  TalkPage(this.uid);

  @override
  _TalkPageState createState() => _TalkPageState();
}

class _TalkPageState extends State<TalkPage> {

  final rooms = FirebaseFirestore.instance.collection('rooms');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF202B42),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Text("編集"),
          onPressed: (){},
        ),
        title: Text("トーク", style: TextStyle(fontWeight: FontWeight.bold),),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.video_call_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.playlist_add_outlined),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(10),
              child: Text(''),
            ),
            floating: true,
            snap: false,
            backgroundColor: Color(0xFF202B42),
            centerTitle: true,
            leading: Container(),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Stack(
                    children: [
                      Positioned(
                        child: GestureDetector(
                          child: Container(
                            height: 45,
                            width: MediaQuery.of(context).size.width * 0.95,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: Color(0xFF323B55),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                children: [
                                  Icon(Icons.search, color: Color(0xFF63697D), size: 25,),
                                  SizedBox(width: 10,),
                                  Text("検索", style: TextStyle(
                                      color: Color(0xFF63697D),
                                      fontSize: 17
                                  )
                                  ),
                                ],
                              ),
                            ),
                          ),
                          onTap: (){
                            //ToDo 検索欄をクリック時の処理
                          },
                        ),
                      ),
                      Positioned(
                        height: 45,
                        right: 10,
                        child: GestureDetector(
                          child: Icon(Icons.qr_code, color: Color(0xFF63697D), size: 25,),
                          onTap: (){
                            //ToDo QRコードリーダーを開く
                          },
                        ),
                      )
                    ],
                  )
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: rooms.where('member', arrayContainsAny: ['${widget.uid}']).snapshots(),
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        final List<DocumentSnapshot> documents = snapshot.data.docs;
                        // return _friendList(documents);
                        return ListView(
                          physics: NeverScrollableScrollPhysics(),
                          children: documents.map((document){
                            return StreamBuilder<Object>(
                              stream: FirebaseFirestore.instance.collection("users").where('uid', isEqualTo: getFriendName(document['member'])).snapshots(),
                              builder: (context, snapshot) {
                                return talkWidget(document, snapshot);
                              }
                            );
                          }).toList(),
                        );
                      }
                      return Container();
                    }
                  )
                )
              ]
            )
          ),
        ],
      )
    );
  }


  Widget talkWidget(document, snapshot){
    return GestureDetector(
      child: Container(
        color: Colors.white.withOpacity(0),
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        height: 80,
        child: Row(
          children: [
            Container(
              child: Center(
                child: Container(
                  width: 65,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(snapshot.data.docs.last['photo_url']),
                        fit: BoxFit.cover,
                      )
                  ),
                ),
              ),
            ),
            Container(
              height: 80,
              width: MediaQuery
                  .of(context)
                  .size
                  .width - 130,
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  friendNameWidget(document, snapshot),
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection("messages").where('room_id', isEqualTo: document.id).orderBy('created_at', descending: false).snapshots(),
                      builder: (context, snapshot) {
                        if(snapshot.hasData){
                          return lastMessageExist(snapshot);
                        }
                        return Container();
                      }
                  ),

                ],
              ),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.only(top: 5),
              height: 80,
              child: Text(
                "昨日",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12
                ),
                textAlign: TextAlign.right,

              ),
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => ChatRoom(
                  roomId: document.id,
                  uid: widget.uid,
                  friendUid: snapshot.data.docs.last['uid'],
                  friendName: snapshot.data.docs.last['name'],
                  friendUrl: snapshot.data.docs.last['photo_url'],
                )
            )
        );
      },
    );
  }

  getFriendName(members) {
    for (int i = 0; i < members.length; i++) {
      if(!(members[i] == widget.uid)) {
        return members[i];
      }
    }
  }

  Widget friendNameWidget(document, snapshot) {

    if(document['room_name'] == null){  //room_nameがnullだったら個人チャット
        return Text(
          snapshot.data.docs.last['name'],
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
            fontSize: 15,
          ),
        );
    } else {
      return Text(
        document['room_name'],
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: TextStyle(
          fontSize: 15,
        ),
      );
    }
  }

  Widget lastMessageExist(snapshot) {

    try{
      return Text(
        snapshot.data.docs.last['content'],
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        style: TextStyle(
            fontSize: 13,
            color: Colors.grey[600]
        ),
      );
    } catch(e){
      // print(e);
      return Text("");
    }
  }

  Widget _friendList(documents) {

  }
}
