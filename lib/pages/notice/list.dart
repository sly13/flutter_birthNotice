import 'package:birt/pages/helper.dart';
import 'package:birt/pages/notice/detail.dart';
import 'package:birt/services/notice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NoticeList extends StatefulWidget {
  NoticeList({Key key}) : super(key: key);

  _NoticeListState createState() => _NoticeListState();
}

class _NoticeListState extends State<NoticeList> {
  // final notesReference = FirebaseDatabase.instance
  //     .reference()
  //     .child('user')
  //     .orderByChild('timestamp');
  Helper helper = Helper();
  Notice notice = new Notice();
  var assetsImage = new AssetImage('assets/loading.gif');
  // var image = new Image(image: assetsImage, width: 500.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Recent & Upcoming'),
          automaticallyImplyLeading: false,
        ),
        body: StreamBuilder(
            // .where("chatDetails.to", isEqualTo: user.uid)
            stream: Firestore.instance
                .collection('user')
                .orderBy('birthday')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                // print(snapshot.hasData);
                // var image = Image(
                //   image: assetsImage,
                //   height: 100.0,
                //   width: 100.0,
                // );
                // return Container(alignment: Alignment(0.0, 0.0), child: image);
                return Container(
                    alignment: Alignment(0.0, 0.0), child: Text('Loading'));
              } else {
                return ListView.builder(
                    // shrinkWrap: true,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot user = snapshot.data.documents[index];

                      String birthdayDate = DateFormat('dd.MM.yyyy')
                          .format(user['birthday'].toDate());

                      int difference = helper.daysToBirthday(user['birthday']);
                      return Dismissible(
                        background: Container(color: Colors.red),
                        onDismissed: (direction) async {
                          notice.delete(
                              snapshot.data.documents[index].documentID);
                        },
                        key: ObjectKey(user),
                        child: new InkWell(
                          // GestureDetector - without effects
                          onTap: () {
                            print(snapshot.data.documents[index]['name']);
                            // Navigator.pushNamed(context, '/about',
                            //     arguments: <String, String>{
                            //       'id': snapshot.data.documents[index].documentID,
                            //     });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailNotice(
                                    user: snapshot.data.documents[index]),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(20.0),
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 120.0,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(top: 8.0, bottom: 8.0),
                                    child: Material(
                                      color: Colors.white,
                                      elevation: 14.0,
                                      shadowColor: Color(0x802196F3),
                                      child: Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Column(
                                            children: <Widget>[
                                              // Container(
                                              //   // width: MediaQuery.of(context).size.width,
                                              //   height: 200.0,
                                              //   child: Image.network(
                                              //     '${user['image']}',
                                              //     fit: BoxFit.fill,
                                              //   ),
                                              // ),
                                              SizedBox(height: 10.0),
                                              Text(
                                                '${user['name']}',
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(height: 10.0),
                                              Text(
                                                birthdayDate ?? DateTime.now(),
                                                style: TextStyle(
                                                    color: Colors.blueGrey,
                                                    fontSize: 16.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(height: 10.0),
                                              Text(
                                                'Throw ' +
                                                    difference.toString() +
                                                    ' days',
                                                style: TextStyle(
                                                    fontSize: 14.0,
                                                    color: Colors.blueGrey,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              }
            }));
  }
}
