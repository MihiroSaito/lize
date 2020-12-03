import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lize/views/sign_up.dart';
import 'package:lize/views/user_page.dart';

class Initial extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.75,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25.0),
                      child: Image.asset(
                        'images/LIZE-icon.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text(
                    'LIZEへようこそ',
                    style: Theme.of(context).textTheme.headline5.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                    )
                  ),
                  SizedBox(height: 10,),
                  Text(
                    '無料のメールや音声・ビデオ通話を楽しもう！',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: RaisedButton(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 15),
                        child: Text("ログイン"),
                      ),
                      color: Color(0xFF1DBD04),
                      textColor: Colors.white,
                      onPressed: (){
                        Navigator.push(
                            context,
                            CupertinoPageRoute(builder: (context) => UserPage())
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10,),
                  FlatButton(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      child: Text("新規登録"),
                    ),
                    onPressed: (){
                      Navigator.push(
                        context,
                        CupertinoPageRoute(builder: (context) => SignUp())
                      );
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
