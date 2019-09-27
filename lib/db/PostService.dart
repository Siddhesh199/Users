import 'package:firebase_database/firebase_database.dart';


class PostService{
  String nodeName = "posts";
  FirebaseDatabase database = FirebaseDatabase.instance;
  Map post;

  PostService(this.post);

  addPost(){
    database.reference().child(nodeName).push().set(post);
  }

  deletePost(){
    database.reference().child('$nodeName/${post['key']}').remove();
  }

  updatePost(){
    database.reference().child('$nodeName/${post['key']}').update(
        {"title": post['title'], "body": post['body'], "date":post['date']}
    );
  }
}