import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';

class UserServices {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  String ref = "users";
  createUser(Map value) {
    String id = value["userId"];
    _database
        .ref()
        .child("$ref/$id")
        .push()
        .set(value)
        .catchError((e) => {log(e.toString())});
  }
}
