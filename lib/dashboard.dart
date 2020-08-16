import 'package:firebase_app/add_post.dart';
import 'package:firebase_app/login.dart';
import 'package:firebase_app/posts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
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
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
                child: Text('Add Post'),

                onPressed:(){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AddPost()));
                }

            ),
            RaisedButton(
                child: Text('See All Posts'),

                onPressed:(){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PostsScreen()));
                }

            ),
          ],
        ),
      ),
    );
  }

}
