import 'package:firebase_database/firebase_database.dart';


class UserService{
  String nodeName = "posts";
  FirebaseDatabase database = FirebaseDatabase.instance;
  Map user;

  UserService(this.user);

  addUser(){
    database.reference().child(nodeName).push().set(user);
  }

  updateUser(){
    database.reference().child('$nodeName/${user['key']}').update(
        {"title": user['title'], "body": user['body'], "date":user['date']}
    );
  }
}