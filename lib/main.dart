import 'package:birt/pages/auth/signIn.dart';
import 'package:birt/pages/auth/signUp.dart';
import 'package:birt/pages/firebase_notification_handler.dart';
import 'package:birt/pages/home.dart';
import 'package:birt/pages/notice/create.dart';
import 'package:birt/pages/notice/list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  void initState() {
    initState();
    new FirebaseNotifications().setUpFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Birthdays Notice',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: _handleWindowDisplay(),
      initialRoute: '/signIn',
      routes: {
        '/signIn': (context) => SignInPage(),
        '/signUp': (context) => SignUpPage(),
        '/create': (content) => NewNotice(),
        '/list': (content) => Home(),
        // '/about': (content) => DetailNotice(),
      },
    );
  }
}

Widget _handleWindowDisplay() {
  return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Text('Loading'));
        } else {
          if (snapshot.hasData) {
            return Home();
          } else {
            return NoticeList();
            // return SignInPage();
          }
        }
      });
}
