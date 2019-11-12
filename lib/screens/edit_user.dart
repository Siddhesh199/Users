import 'package:sid_blog/db/UserService.dart';
import 'package:sid_blog/models/user.dart';
import 'package:sid_blog/screens/home.dart';
import 'package:flutter/material.dart';

class EditUser extends StatefulWidget {
  final User user;

  EditUser(this.user);

  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  final GlobalKey<FormState> formkey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit User"),
        elevation: 0.0,
      ),
      body: Form(
        key: formkey,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: widget.user.title,
                decoration: InputDecoration(
                    labelText: "Post tilte", border: OutlineInputBorder()),
                onSaved: (val) => widget.user.title = val,
                validator: (val) {
                  if (val.isEmpty) {
                    return "title field cant be empty";
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: widget.user.body,
                decoration: InputDecoration(
                  labelText: "Post body",
                  border: OutlineInputBorder(),
                ),
                onSaved: (val) => widget.user.body = val,
                validator: (val) {
                  if (val.isEmpty) {
                    return "body field cant be empty";
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
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
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
      widget.user.date = DateTime.now().millisecondsSinceEpoch;
      UserService userService = UserService(
        widget.user.toMap(),
      );
      userService.updateUser();
    }
  }
}
