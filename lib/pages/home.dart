import 'package:birt/pages/notice/list.dart';
import 'package:birt/pages/placeholderWidget.dart';
import 'package:birt/pages/settings.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  // const Home({Key key, @required this.user}) : super(key: key);
  // final FirebaseUser user;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    NoticeList(),
    // PlaceholderWidget(Colors.white),
    Settings()
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Recent & Upcoming'),
      //   automaticallyImplyLeading: false,
      // ),
      body: _children[_currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/create');
          // Add your onPressed code here!
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.cyan,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.notifications),
            title: new Text('Birthdays'),
          ),
          // BottomNavigationBarItem(
          //   icon: new Icon(Icons.mail),
          //   title: new Text('Messages'),
          // ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text('Profile'))
        ],
      ),
    );
  }
}
