import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lize/views/chat_room.dart';


class TalkPage extends StatefulWidget {
  @override
  _TalkPageState createState() => _TalkPageState();
}

class _TalkPageState extends State<TalkPage> {

  var list = ["メッセージ", "メッセージ", "メッセージ", "メッセージ", "メッセージ",];

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
                  padding: EdgeInsets.only(top: 5),
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index){
                      if (index >= list.length) {
                        list.addAll(["メッセージ","メッセージ","メッセージ","メッセージ",]);
                      }
                      return _friendList(list[index]);
                    }
                  ),
                )
              ]
            )
          ),
        ],
      )
    );
  }

  Widget _friendList(String title) {
    return GestureDetector(
      child: Container(
        child: Container(
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
                        image: AssetImage('images/LIZE-icon.jpg'),
                        fit: BoxFit.cover,
                      )
                    ),
                  ),
                ),
              ),
              Container(
                height: 80,
                width: MediaQuery.of(context).size.width - 130,
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ここに友達の名前が入る",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "ここにトークの最後のメッセージが２行まで入ります。",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600]
                      ),
                    )
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
        )
      ),
      onTap: (){
        Navigator.push(
            context,
            CupertinoPageRoute(builder: (context) => ChatRoom())
        );
      },
    );

  }
}
