import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lize/views/initial.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lize/views/user_page.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LIZE',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool isLoggedIn = false;

  @override
  void initState(){
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      isLoggedIn = false;
    } else {
      isLoggedIn = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoggedIn ? UserPage() : Initial();
  }
}
