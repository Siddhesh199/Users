import 'package:sid_blog/db/UserService.dart';
import 'package:sid_blog/models/user.dart';
import 'package:flutter/material.dart';

class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final GlobalKey<FormState> formkey = new GlobalKey();
  User user = User(0, " ", " ");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add User"),
        elevation: 0.0,
      ),
      body: Form(
        key: formkey,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "First Name", border: OutlineInputBorder()),
                onSaved: (val) => user.title = val,
                validator: (val) {
                  if (val.isEmpty) {
                    return "First Name cant be empty";
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Last Name", border: OutlineInputBorder()),
                onSaved: (val) => user.body = val,
                validator: (val) {
                  if (val.isEmpty) {
                    return "Last Name cant be empty";
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          insertPost();
          Navigator.pop(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void insertPost() {
    final FormState form = formkey.currentState;
    if (form.validate()) {
      form.save();
      form.reset();
      user.date = DateTime.now().millisecondsSinceEpoch;
      UserService postService = UserService(user.toMap());
      postService.addUser();
    }
  }
}
