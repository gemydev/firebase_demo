import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class AddPost extends StatefulWidget{
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {

  final FirebaseMessaging _fcm = FirebaseMessaging();

  void initState()
  {
    super.initState();
    _fcm.getToken().then((token){
      Firestore.instance.collection('tokens').add({
        'token':token
      });
    });

  }

  final _formKey = GlobalKey<FormState>();

  TextEditingController _postTitle , _postDescription  = TextEditingController();


  @override
  void dispose()
  {
    _postTitle.dispose();
    _postDescription.dispose();
    super.dispose();
  }

  updatePost(String id){
    Firestore.instance.collection('posts').document(id).setData({
      'title':"Title Edited",
      'description':"Description Edited"
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(' Add Post'),
        actions: <Widget>[
          RaisedButton(
              child: Text('Log Out',style: TextStyle(fontSize: 18,color: Colors.white),),
              color: Colors.blue,
              onPressed: () async{
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
              }
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _postTitle,
                decoration: InputDecoration(
                  hintText: 'Post Title',
                ),
                validator: (value){
                  if(value.isEmpty){
                    return 'Please Fill Post Title Input';
                  }else{
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                controller: _postDescription,
                decoration: InputDecoration(
                  hintText: 'Description',
                ),
                validator: (value){
                  if(value.isEmpty){
                    return 'Please Fill Description Input';
                  }else{
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                color: Colors.blue,
                child: Text('Add Post',style: TextStyle(color: Colors.white),),
                onPressed: () async{
                  if(_formKey.currentState.validate()){

                    // add post
                    var currentUser = await FirebaseAuth.instance.currentUser();
                    Firestore.instance.collection('posts').document().setData({
                      'post_title':_postTitle.text,
                      'post_description' : _postDescription.text,
                      'user': {
                        'uid':currentUser.uid,
                        'email':currentUser.email,
                      }
                    });
                  }
                },
              ),
              RaisedButton(
                color: Colors.blue,
                child: Text('Delete Post',style: TextStyle(color: Colors.white),),
                onPressed: () async{
                  if(_formKey.currentState.validate()){

                    // Delete post

                    Firestore.instance.collection('posts').document('hIbH9XJv5Fkt2YzN2wII').delete().then((onValue){
                      print('Post Deleted Successfully');
                    });


                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }


}