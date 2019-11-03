import 'package:birt/services/notice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UpdateNotice extends StatelessWidget {
  final DocumentSnapshot user;
  UpdateNotice({Key key, @required this.user}) : super(key: key);
  final format = DateFormat("yyyy-MM-dd");
  DateTime birthday;

  Notice notice = new Notice();
  String name, image;

  getName(name) {
    this.name = name;
  }

  getBirthday(birthday) {
    this.birthday = birthday;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Notice'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - 80,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              child: TextFormField(
                initialValue: user['name'],
                onChanged: (String name) {
                  getName(name);
                },
                decoration: InputDecoration(labelText: 'Name'),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              child: DateTimeField(
                decoration: InputDecoration(labelText: 'Birthday'),
                format: format,
                initialValue: user['birthday'].toDate() ?? DateTime.now(),
                onShowPicker: (context, currentValue) {
                  // var currentValue = getBirthday();
                  print(currentValue);
                  return showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100));
                },
                validator: (birthday) =>
                    birthday == null ? 'Invalid date' : null,
                onChanged: (birthday) {
                  print(birthday);
                  getBirthday(birthday);
                },
                onSaved: (birthday) {
                  print(birthday);
                  getBirthday(birthday);
                },
              ),
            ),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.teal,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    RaisedButton(
                      child: const Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.teal,
                      onPressed: () {
                        notice.update(name, user, birthday, image, context,
                            user.documentID);
                      },
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
