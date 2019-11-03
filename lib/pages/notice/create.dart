import 'package:birt/services/notice.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewNotice extends StatefulWidget {
  NewNotice();

  _NewNoticeState createState() => _NewNoticeState();
}

class _NewNoticeState extends State<NewNotice> {
  String name, image;
  DateTime birthday;

  Notice notice = new Notice();
  final format = DateFormat("yyyy-MM-dd");

  getName(name) {
    this.name = name;
  }

  getBirthday(birthday) {
    this.birthday = birthday;
  }

  getImage(image) {
    this.image = image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create notice'),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - 80,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              child: TextField(
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
                onShowPicker: (context, currentValue) {
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
                        notice.create(name, birthday, image, context);
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
