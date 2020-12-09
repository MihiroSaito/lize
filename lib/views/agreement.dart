import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lize/views/user_page.dart';
import 'package:url_launcher/url_launcher.dart';

class Agreement extends StatefulWidget {

  final String uid;
  final String email;
  final String name;
  final String url;

  const Agreement({Key key, this.uid, this.email, this.name, this.url}) : super(key: key);

  @override
  _AgreementState createState() => _AgreementState();
}

class _AgreementState extends State<Agreement> {


  @override
  Widget build(BuildContext context) {

    var padding = MediaQuery.of(context).padding.top + MediaQuery.of(context).padding.bottom;

    var viewSize = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: (viewSize - padding) * 0.80,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'サービス向上のための情報利用に関するお願い',
                              style: TextStyle(
                                fontWeight: FontWeight.w800
                              ),
                            ),
                            Container(
                              width: 200,
                              height: 170,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('images/GPS.png'),
                                  fit: BoxFit.cover
                                )
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.50,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '最適な情報・サービスを提供するために位置情報などの活用を推進します',
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                'あなたの安全を守るための情報や、生活に役立つ情報を、位置情報に基づいて提供するための取組を推進します。同意いただくことで、例えば、大規模災害時の緊急速報等の重要なお知らせや、今いるエリアの天候の変化、近くのお店で使えるクーポンなどをお届けできるようにしていきたいと考えております。',
                              ),
                              SizedBox(height: 20,),
                              Text(
                                '取得する情報とその取り扱いについて',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  text: '■',
                                  style: TextStyle(color: Colors.grey[700]),
                                  children: [
                                    TextSpan(
                                      text: '本項目に同意しなくとも、LIZEアプリは引き続きご利用可能です。',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ]
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                    text: '■',
                                    style: TextStyle(color: Colors.grey[700]),
                                    children: [
                                      TextSpan(
                                        text: 'LIZEによる端末の取得停止や、取得された位置情報の削除は、[設定]＞[プライバシー管理]＞[情報の提供]からいつでも行えます。',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ]
                                ),
                              ),
                              SizedBox(height: 20,),
                              Text(
                                '<端末の位置情報>',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  text: 'LIZEは上記サービスを提供するため、LIZEアプリが画面に表示されている際に、ご利用の端末の位置情報と移動速度を取得することがあります。取得した情報は',
                                  style: TextStyle(color: Colors.black),
                                  children: [
                                    TextSpan(
                                      text: 'プライバシーポリシー',
                                      style: TextStyle(
                                        color: Color(0xFF1DBD04),
                                        decoration: TextDecoration.underline
                                      ),
                                      recognizer: TapGestureRecognizer()..onTap = (){
                                        launch('https://flutter.dev/');
                                      },
                                    ),
                                    TextSpan(
                                      text: 'に従って取り扱います。詳細は',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    TextSpan(
                                      text: 'こちら',
                                      style: TextStyle(
                                          color: Color(0xFF1DBD04),
                                          decoration: TextDecoration.underline
                                      ),
                                      recognizer: TapGestureRecognizer()..onTap = (){
                                        launch('https://flutter.dev/');
                                      },
                                    ),
                                    TextSpan(
                                      text: 'をご覧ください。',
                                      style: TextStyle(color: Colors.black),
                                    )
                                  ]
                                ),
                              ),
                              SizedBox(height: 20,),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: (viewSize - padding) * 0.20,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.grey[300],
                    width: 2,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: RaisedButton(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15, bottom: 15),
                            child: Text("許可する"),
                          ),
                          color: Color(0xFF1DBD04),
                          textColor: Colors.white,
                          onPressed: (){
                            _getLocationInfo();
                          },
                        ),
                      ),
                      SizedBox(height: 10,),
                      FlatButton(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 15),
                          child: Text("許可しない"),
                        ),
                        onPressed: (){
                          Navigator.pushReplacement(
                              context,
                              CupertinoPageRoute(
                                  builder: (BuildContext context) =>
                                      UserPage(uid: widget.uid,
                                          email: widget.email,
                                          name: widget.name,
                                          url: widget.url,
                                      )
                              )
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }

  Future _getLocationInfo() async{

    LocationPermission permission = await Geolocator.requestPermission().then((value){
      print(value);
      if(value == LocationPermission.deniedForever || value == LocationPermission.denied) {
        showDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text("位置情報が取得できませんでした"),
              content: Text("OKを押したら設定画面へ遷移します。"),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.pop(context);
                    Geolocator.openLocationSettings();
                  }
                ),
              ]
            );
          },
        );
      }
      if(value == LocationPermission.always || value == LocationPermission.whileInUse){
        Navigator.pushReplacement(
            context,
            CupertinoPageRoute(
                builder: (BuildContext context) =>
                    UserPage(uid: widget.uid,
                        email: widget.email,
                        name: widget.name,
                        url: widget.url,
                        firstLog: true
                    )
            )
        );
      }
    }).catchError((e){
      print(e);
    });

  }
}
