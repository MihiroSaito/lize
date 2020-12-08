import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {

  bool isLoading = true;

  void _endLoad(String value){
    print("読み込み完了");
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF202B42),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.dehaze),
          onPressed: (){},
        ),
        title: Text("ニュース", style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: "https://news.yahoo.co.jp/",
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: _endLoad,
          ),
          Positioned(
            child: isLoading? Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.grey),
                ),
              ),
            ) : SizedBox()
          )
        ],
      ),
    );
  }
}
