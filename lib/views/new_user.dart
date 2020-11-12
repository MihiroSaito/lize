import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'chat_room.dart';

class NewUser extends StatefulWidget {

  final String uid;
  final String email;
  final String name;

  const NewUser({Key key, this.uid, this.email, this.name}) : super(key: key);

  @override
  _NewUserState createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {

  final picker = ImagePicker();

  final _form = GlobalKey<FormState>();

  final nameController = TextEditingController();

  bool imageNull = true;

  bool isLoading = false;

  File _image;

  @override
  Widget build(BuildContext context) {

    final bottomSpace = MediaQuery.of(context).viewInsets.bottom;

    if(widget.name != null) {
      nameController.text = widget.name;
    }

    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                leading: Container(),
                actions: [
                  IconButton(icon: Icon(Icons.info_outline, color: Colors.grey,),
                      onPressed: () {})
                ],

              ),
              resizeToAvoidBottomInset: false,
              body: SingleChildScrollView(
                reverse: true,
                child: Padding(
                  padding: EdgeInsets.only(left: 40.0, right: 40.0, bottom: bottomSpace + 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "アカウント情報登録",
                        style: Theme.of(context).textTheme.headline5.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(height: 10,),
                      Text(
                        'プロフィールに登録した名前と写真は、LIZEサービス上で公開されます。',
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 20,),
                      GestureDetector(
                        child: imageNull? Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            border: Border.all(color: Colors.grey[300], width: 2)
                          ),
                          child: Icon(Icons.camera_alt, color: Colors.grey[300],),
                        ) : Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300], width: 2),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: FileImage(_image)
                            )
                          ),

                        ),
                        onTap: (){
                          getImageFromGallery();
                        },
                      ),
                      SizedBox(height: 20,),
                      Form(
                        key: _form,
                        child: TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            hintText: '名前',
                            labelStyle: TextStyle(
                              color: Colors.grey[700]
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.cancel, color: Colors.grey[400],),
                              onPressed: (){
                                nameController.text = "";
                              },
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[400], width: 2)
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[400], width: 2)
                            ),
                          ),
                          keyboardType: TextInputType.name,
                          cursorColor: Colors.grey[500],
                          validator: (value) {
                            if (value.isEmpty) {
                              return '入力してください';
                            }
                            if (20 < value.length) {
                              return '名前は20文字以内で入力してください';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 40,),
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
                                  saveData().then((value) {
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
                )
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
          ]
        ),
      ),
    );
  }

  Future getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if(pickedFile != null) {
        imageNull = false;
        _image = File(pickedFile.path);
      }
    });
  }

  Future saveData() async {
    try{
      setState(() {
        isLoading = true;
      });
      var imageURL;
      if(_image != null){
        imageURL = await uploadProfileImage();
      }

      final doc = FirebaseFirestore.instance.collection("users").doc(widget.uid);
      await doc.set(
        {
          'uid': widget.uid,
          'name': nameController.text,
          'email': widget.email,
          'photo_url': imageURL,
          'user_verification': true,
          'created_at': DateTime.now(),
        }
      );
      Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
              builder: (BuildContext context) =>
                  ChatRoom(uid: widget.uid,
                      email: widget.email,
                      name: nameController.text,
                      url: imageURL)
          )
      );
    } catch(e) {
      print(e);
    }
  }

  Future uploadProfileImage() async {
    try {
      await FirebaseStorage.instance.ref('images/user_${widget.uid}/profile_image/${widget.uid}').putFile(_image);
      String downloadURL = await FirebaseStorage.instance.ref('images/user_${widget.uid}/profile_image/${widget.uid}').getDownloadURL();
      return downloadURL;
    } on FirebaseException catch (e) {
      print(e);
    }
  }
}
