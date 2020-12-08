import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lize/views/new_user.dart';
import 'package:lize/views/user_page.dart';

class LogIn extends StatefulWidget {

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final _form = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;

  final _firestore = FirebaseFirestore.instance;

  GoogleSignIn _googleSignIn = GoogleSignIn();

  FacebookLogin _facebookSignIn = FacebookLogin();

  bool _showPassword = true;

  bool isLoading = false;


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black, // status bar color
    ));

    //キーボードの高さを取得
    final bottomSpace = MediaQuery.of(context).viewInsets.bottom;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.black,),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
              actions: [
                IconButton(icon: Icon(Icons.info_outline, color: Colors.grey,), onPressed: (){})
              ],

            ),
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              reverse: true,
              child: Padding(
                padding: EdgeInsets.only(left: 40.0, right: 40.0, bottom: bottomSpace + 10),
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "LIZEにログイン",
                            style: Theme.of(context).textTheme.headline5.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(height: 10,),
                          Text(
                            'LIZEに登録されているメールアドレスでログインしてください。',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            '以前にLIZEとFacebookまたはGoogleを連携させていた場合は各アカウントでもログインできます。',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 50,),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: RaisedButton.icon(
                        icon: Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: SizedBox(
                            height: 25,
                            child: ClipRRect(
                              child: Image.asset(
                                'images/google-icon.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        label: Text('Googleアカウント'),
                        onPressed: (){
                          handleLogInWithGoogle().then((value) {
                            setState(() {
                              isLoading = false;
                            });
                          }).catchError((onError){
                            setState(() {
                              isLoading = false;
                            });
                          });
                        },
                        color: Colors.white,
                        textColor: Colors.black,
                        shape: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[300]),
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: RaisedButton.icon(
                        label: Text('FaceBookアカウント'),
                        icon: Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: SizedBox(
                            height: 25,
                            child: ClipRRect(
                              child: Image.asset(
                                'images/f_logo_RGB-White_250.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        onPressed: (){
                          handleLogInWithFB().then((value) {
                            setState(() {
                              isLoading = false;
                            });
                          }).catchError((onError){
                            setState(() {
                              isLoading = false;
                            });
                          });
                        },
                        color: Color(0xFF3B5998),
                        textColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 40,),
                    Text('もしくは', style: TextStyle(color: Colors.grey),),
                    SizedBox(height: 30,),
                    Form(
                      key: _form,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                labelText: 'メールアドレス',
                                labelStyle: TextStyle(
                                    color: Colors.grey[700]
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey[700])
                                ),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey[700])
                                ),
                              ),
                              validator: (value){
                                if(value.isEmpty){
                                  return '入力してください';
                                }
                                if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)){
                                  return "メールアドレスが有効ではありません";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              cursorColor: Colors.grey[700],

                            ),
                            TextFormField(
                              controller: passwordController,
                              decoration: InputDecoration(
                                labelText: 'パスワード',
                                labelStyle: TextStyle(
                                    color: Colors.grey[700]
                                ),
                                suffixIcon: IconButton(
                                  icon: _showPassword
                                      ? Icon(Icons.remove_red_eye_outlined,color: Colors.grey[700],)
                                      : Icon(Icons.visibility_off_outlined,color: Colors.grey[700],),
                                  onPressed: (){
                                    setState(() {
                                      _showPassword = !_showPassword;
                                    });
                                  },
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey[700]),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey[700])
                                ),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return '入力してください';
                                }
                                if (8 > value.length) {
                                  return 'パスワードは８文字以上で入力してください';
                                }
                                if (!(RegExp(r'(?=.*?[a-z])(?=.*?[0-9]).{8,}$').hasMatch(value))){
                                  return '半角英数字をそれぞれ1つ以上含めてください';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: _showPassword,
                              textInputAction: TextInputAction.done,
                              cursorColor: Colors.grey[700],
                            ),
                            SizedBox(height: 40,),
                          ],
                        ),
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          RaisedButton(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Icon(Icons.arrow_forward, color: Colors.white,),
                            ),
                            shape: const CircleBorder(),
                            color: Color(0xFF1DBD04),
                            onPressed: (){
                              FocusScope.of(context).unfocus();
                              if(_form.currentState.validate()){
                                handleLogInWithEmail().then((value) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                });
                              }
                            },
                          ),
                        ]
                    )
                  ],
                ),
              ),
            ),
          ),
          isLoading? Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.black.withOpacity(0.4),
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            ),
          ) : SizedBox()
        ],
      ),
    );
  }

  Future<void> handleLogInWithEmail() async {
    try {
      setState(() {
        isLoading = true;
      });
      final UserCredential _result = await _auth.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text
      );
      final User user = _result.user;
      UserVerification(user);
    } catch(e){
      alertError(e);
    }
  }

  Future<void> handleLogInWithGoogle() async {
    try {
      setState(() {
        isLoading = true;
      });
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuth = await googleSignInAccount
          .authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuth.idToken,
          accessToken: googleSignInAuth.accessToken
      );
      UserCredential _result = await _auth.signInWithCredential(credential);
      User _user = _result.user;
      UserVerification(_user);
    } catch (e) {
      alertError(e);
    }
  }

  Future<void> handleLogInWithFB() async {
    try {
      setState(() {
        isLoading = true;
      });
      final result = await _facebookSignIn.logIn((['email']));
      final FacebookAuthCredential facebookAuthCredential =
      FacebookAuthProvider.credential(result.accessToken.token);

      UserCredential resultFB = await _auth.signInWithCredential(
          facebookAuthCredential);
      User _user = resultFB.user;
      UserVerification(_user);
    } catch(e){
      alertError(e);
    }
  }

  Future<void> UserVerification(_user) async {
    final users = _firestore.collection('users');
    DocumentSnapshot snapshot = await users.doc(_user.uid).get();
    if(snapshot.exists) {
      final uid = snapshot.data()['uid'];
      final email = snapshot.data()['email'];
      final name = snapshot.data()['name'];
      Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
              builder: (BuildContext context) =>
                  UserPage(uid: uid,
                    email: email,
                    name: name,
                  )
          )
      );
    } else {
      Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
              builder: (BuildContext context) =>
                  NewUser(uid: _user.uid,
                    email: _user.email,
                    name: _user.displayName,
                  )
          )
      );
    }
  }

  alertError(e){

    String errorMessage;

    switch (e.code) {
      case 'user-not-found':
        errorMessage =  'アカウントが見つかりませんでした。';
        break;
      case 'user-disabled':
        errorMessage = 'このアカウントはブロックされています';
        break;
      case 'account-exists-with-different-Credential':
        errorMessage = '選択したアカウントと同じメールアドレスで作成されたアカウントが既に存在します';
        break;
      default:
        errorMessage = '予期せぬエラーが発生しました。(エラー: ${e.code})';
    }

    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
            title: Text(errorMessage),
            actions: <Widget>[
              CupertinoDialogAction(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.pop(context);
                  }
              ),
            ]
        );
      },
    );
  }


}