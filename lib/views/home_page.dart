import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {

  final String uid;
  final String email;
  final String name;
  final String url;
  final bool complete;

  HomePage({this.uid, this.email, this.name, this.url, this.complete});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

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
            onPressed: (){},
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
                                    width: MediaQuery.of(context).size.width / 6,
                                    height: MediaQuery.of(context).size.width / 6,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(50)),
                                        border: Border.all(color: Colors.grey[300], width: 2)
                                    ),
                                  ),
                                  SizedBox(width: 20,),
                                  Expanded(
                                    child: Text("田中太郎", style: TextStyle(
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
                          child: GestureDetector(
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
}
