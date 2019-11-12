import 'package:sid_blog/models/user.dart';
import 'package:flutter/material.dart';
import 'add_user.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sid_blog/screens/edit_user.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseDatabase _database = FirebaseDatabase.instance;
  String nodeName = "posts";
  List<User> usersList = <User>[];
  int _perPage = 12;

  GlobalKey<RefreshIndicatorState> refreshKey;

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {

    });

    return null;
  }


  @override
  void initState() {
    refreshKey = GlobalKey<RefreshIndicatorState>();
    _database.reference().child(nodeName).onChildAdded.listen(_childAdded);
    _database.reference().child(nodeName).onChildChanged.listen(_childChanged);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users List"),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Visibility(
              visible: usersList.isEmpty,
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  alignment: Alignment.center,
                  child: Text(
                    'No Users',
                    style: TextStyle(fontSize: 40.0),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: usersList.isNotEmpty,
              child: Flexible(
                child: RefreshIndicator(
                  key: refreshKey,
                  onRefresh: (){
                    return refreshList();
                  },
                  child: FirebaseAnimatedList(
                    query: _database.reference().child('posts').limitToFirst(_perPage),
                    itemBuilder: (_, DataSnapshot snap,
                        Animation<double> animation, int index) {
                      return ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditUser(
                                  usersList[index],
                                ),
                              ),
                            );
                          },
                          title: Text(
                            usersList[index].title,
                            style: TextStyle(fontSize: 18.0),
                          ),
                        subtitle: Text(
                          usersList[index].body,
                          style: TextStyle(fontSize: 18.0),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddPost()));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  _childAdded(Event event) {
    setState(
      () {
        usersList.add(
          User.fromSnapshot(event.snapshot),
        );
      },
    );
  }

  void _childChanged(Event event) {
    var changedPost = usersList.singleWhere(
      (post) {
        return post.key == event.snapshot.key;
      },
    );

    setState(
      () {
        usersList[usersList.indexOf(changedPost)] =
            User.fromSnapshot(event.snapshot);
      },
    );
  }
}
