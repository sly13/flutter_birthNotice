import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Notice {
  void create(name, birthday, image, context) {
    DocumentReference ds = Firestore.instance.collection('user').document();
    Map<String, dynamic> task = {
      "name": name,
      "birthday": birthday,
      "image": image,
    };

    ds.setData(task);
    Navigator.pushNamed(context, '/list');
  }

  void update(name, user, birthday, image, context, userId) {
    print(birthday);
    DocumentReference ds =
        Firestore.instance.collection('user').document(userId);
    Map<String, dynamic> notice = {
      "name": name ?? user['name'],
      "birthday": birthday ?? user['birthday'].toDate(),
      "image": image,
    };

    ds.updateData(notice);

    Navigator.pushNamed(context, '/list');
  }

  void delete(userId) {
    Firestore.instance
        .collection('user')
        .document(userId)
        .delete()
        .catchError((e) {
      print(e);
    });
  }
}
