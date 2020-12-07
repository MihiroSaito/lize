import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
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
      body: WebView(
        initialUrl: "https://news.yahoo.co.jp/",
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
