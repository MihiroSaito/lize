import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lize/main.dart';
import 'package:lize/views/friend_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {

  final String uid;
  final String name;
  final String url;

  HomePage({this.uid, this.name, this.url});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // // String name = "";
  // // String url = "";
  // // String uid = "";
  //
  // @override
  // void initState() {
  //   super.initState();
  //   // 初期化時にShared Preferencesに保存している値を読み込む
  //   getData();
  // }
  // getData() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     uid = prefs.getString('user_uid') ?? "未設定";
  //     name = prefs.getString('user_name') ?? "未設定";
  //     url = prefs.getString('user_url') ?? "未設定";
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF202B42),
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.settings),
            onPressed: () async {
              final SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.remove('user_uid');
              await prefs.remove('user_name');
              await prefs.remove('user_url');
              await FirebaseAuth.instance.signOut();
              print('ログアウト');
              Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                      builder: (BuildContext context) =>
                          MyApp()
                  )
              );
            },
          ),
          title: Text("ホーム", style: TextStyle(fontWeight: FontWeight.bold),),
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.notifications_none_outlined),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.person_add_alt),
            ),
          ],
        ),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              bottom: PreferredSize(                       // Add this code
                preferredSize: Size.fromHeight(10),      // Add this code
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                    child: Container(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 7,
                            child: Container(
                              child: Row(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width / 6.5,
                                    height: MediaQuery.of(context).size.width / 6.5,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(50)),
                                        image: DecorationImage(
                                          image: NetworkImage(widget.url),
                                          fit: BoxFit.cover
                                        )
                                    ),
                                  ),
                                  SizedBox(width: 20,),
                                  Expanded(
                                    child: Text(widget.name, style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              child: Center(
                                child: GestureDetector(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey[300], width: 1),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                                      child: Text('Keep', style: TextStyle(fontSize: 14),textScaleFactor: 1.0,),
                                    ),
                                  ),
                                  onTap: (){
                                    print('pressed keep');
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.grey[300])
                            )
                          ),
                          child: GestureDetector(
                            child: ListTile(
                              leading: Icon(Icons.star_border, color: Colors.black,),
                              title: Text('お気に入り', style: TextStyle(
                                  fontWeight: FontWeight.bold
                              ),),
                              trailing: GestureDetector(
                                child: Icon(Icons.keyboard_arrow_down),
                              ),
                            ),
                            onTap: (){
                              print("pressed お気に入り");
                            },
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.grey[300])
                              )
                          ),
                          child: GestureDetector(
                            child: ListTile(
                              leading: Icon(Icons.people_outline, color: Colors.black,),
                              title: Text('グループ', style: TextStyle(
                                  fontWeight: FontWeight.bold
                              ),),
                              trailing: GestureDetector(
                                child: Icon(Icons.keyboard_arrow_down),
                              ),
                            ),
                            onTap: (){
                              print("pressed グループ");
                            },
                          ),
                        ),
                        Container(
                          child: Column(
                            children: [
                              GestureDetector(
                                child: ListTile(
                                  leading: Icon(Icons.person_outline, color: Colors.black,),
                                  title: Text('友だち', style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),),
                                  trailing: GestureDetector(
                                    child: Icon(Icons.keyboard_arrow_down),
                                  ),
                                ),
                                onTap: (){
                                  print("pressed 友だち");
                                },
                              ),
                              FriendsList()
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('サービス', style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                              ),),
                              Text('もっと見る', style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[500]
                              ),),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15, bottom: 5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 4 - 10,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Icon(Icons.chat_bubble_outline, size: 35, color: Colors.grey[700],),
                                          SizedBox(height: 5,),
                                          Text("オープンチャット")
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 4 - 10,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Icon(Icons.tag_faces, size: 35, color: Colors.grey[700],),
                                          SizedBox(height: 5,),
                                          Text("スタンプ")
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 4 - 10,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Icon(Icons.cleaning_services, size: 35, color: Colors.grey[700],),
                                          SizedBox(height: 5,),
                                          Text("着せ替え")
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 4 - 10,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Icon(Icons.videogame_asset_outlined, size: 35, color: Colors.grey[700],),
                                          SizedBox(height: 5,),
                                          Text("GAME")
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.width / 4 - 10,
                            child: GridView.extent(
                              maxCrossAxisExtent: MediaQuery.of(context).size.width / 4 - 10,
                              scrollDirection: Axis.horizontal,
                              children: List<Widget>.generate(
                                10,
                                _iconGenerator,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('最新ヒット曲を無料で聴こう', style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                              ),),
                              Text('もっと見る', style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey[500]
                              ),),
                            ],
                          ),
                          SizedBox(height: 20,),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight: MediaQuery.of(context).size.width / 2.3,
                            ),
                            child: Container(
                              child: GridView.builder(
                                itemCount: 20,
                                scrollDirection: Axis.horizontal,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                  childAspectRatio: 1.5,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  return _musicGenerator(index);
                                }
                              ),
                            ),
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Icon(Icons.info_outline, size: 12, color: Colors.grey[600],),
                              SizedBox(width: 3,),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 1),
                                child: Text(
                                  'LIZE MUSICの一時間ごとの再生数を元にしたランキングです。',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey[600]
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 50,),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: Color(0xFF00B9E4),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                          image: AssetImage('images/lize-mobile.png')
                        )
                      ),
                    ),
                  ),
                  SizedBox(height: 50,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _iconGenerator(int index){
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          child: Container(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 10,
                  height: MediaQuery.of(context).size.width / 10,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      gradient: LinearGradient(
                        begin: FractionalOffset.topLeft,
                        end: FractionalOffset.bottomRight,
                        colors: const[
                          Color(0xFF69FF97),
                          Color(0xFF00E4FF)
                        ]
                      )
                  ),
                ),
                SizedBox(height: 5,),
                Text(
                  "AppName",
                  style: TextStyle(
                    fontSize: 12
                  ),
                )
              ],
            ),
          ),
          onTap: (){
            print("pressed icon$index");
          },
        ),
      ),
    );
  }

  Widget _musicGenerator(int index){
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 3.9,
              height: MediaQuery.of(context).size.width / 3.9,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.all(Radius.circular(5)),
                image: DecorationImage(
                  image: AssetImage('images/pngwing.com.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              width: MediaQuery.of(context).size.width / 3.9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'happy song',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  SizedBox(height: 5,),
                  Text(
                    'yamada',
                    style: TextStyle(
                      color: Colors.grey[600]
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget FriendsList(){

    final users = FirebaseFirestore.instance.collection('users');

    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: users.snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            final List<DocumentSnapshot> documents = snapshot.data.docs;
            final length = documents.length - 1;
            return Container(
              height: MediaQuery.of(context).size.width / 8 * length + (length * 10),
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                children: documents.map((document) {
                  if(!(document['uid'] == widget.uid)) {
                    return GestureDetector(
                      child: Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: Row(
                                  children: [
                                    Container(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width / 8,
                                      height: MediaQuery
                                          .of(context)
                                          .size
                                          .width / 8,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50)),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  document['photo_url'] ??
                                                      'http://kumiho.sakura.ne.jp/twegg/gen_hito.cgi?fr=101&fg=119&fb=134&br=204&bg=214&bb=221'),
                                              fit: BoxFit.cover
                                          )
                                      ),
                                    ),
                                    SizedBox(width: 20,),
                                    Expanded(
                                      child: Text(
                                        document['name'], style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: (){
                        print(document['uid']);
                        Navigator.of(context).push(_createRoute(document['uid'],document['name'],document['photo_url']));
                      },
                    );
                  } else {
                    return Container();
                  }
                }).toList(),
              ),
            );
          }
          return Container();
        }
      ),
    );
  }

  Route _createRoute(friendUid, friendName, friendUrl) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => FriendPage(friendUid: friendUid,
        friendUrl: friendUrl,
        friendName: friendName,
        uid: widget.uid
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
