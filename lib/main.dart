// ignore: unused_import
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laravelcrudapi/add.dart';
import 'package:laravelcrudapi/apis/userapi.dart';
import 'package:laravelcrudapi/details.dart';
import 'package:laravelcrudapi/models/user.dart';

void main() {
  runApp(MyApp());
}

// ignore: must_be_immutable
// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  var navigator = GlobalKey<NavigatorState>();
   User user;
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigator,
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              "Crud with Flutter API",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            leading: Icon(Icons.menu),
            iconTheme: IconThemeData(color: Colors.blue),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  icon: Icon(CupertinoIcons.add_circled,
                      size: 30, color: Colors.black),
                  onPressed: () {
                    navigator.currentState.push(
                      MaterialPageRoute(
                        builder: (context) {
                          return AddUserDetailPage(user);
                        },
                      ),
                    );
                  },
                ),
              )
            ],
          ),
          body: UserListPage(),
        ));
  }
}

class UserListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return UserListPageState();
  }
}

class UserListPageState extends State<UserListPage> {
  User user;
  @override
  void initState() {
    super.initState();
    user = new User();
  }

  @override
  Widget build(BuildContext context) {
    var userAPI = new UserAPI();
    return Padding(
      padding: EdgeInsets.all(10),
      child: FutureBuilder(
          future: userAPI.findAll(),
          builder: (context, AsyncSnapshot<List> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    var card = Card(
                      child: ListTile(
                        title: Text(snapshot.data[index].fullname),
                        subtitle: Text(snapshot.data[index].email),
                        trailing: Wrap(
                          children: [
                            IconButton(
                              icon: Icon(CupertinoIcons.eye,
                                  size: 20, color: Colors.black),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UserDetailPage(
                                      id: snapshot.data[index].id,
                                    ),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(CupertinoIcons.pencil,
                                  size: 20, color: Colors.black),
                              onPressed: () async {
                                var userAPI = new UserAPI();
                                var json =
                                    await userAPI.edit(snapshot.data[index].id);
                                print(json.toJson());
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AddUserDetailPage(json)),
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(CupertinoIcons.delete,
                                  size: 20, color: Colors.black),
                              onPressed: () async {
                                var userAPI = new UserAPI();
                                await userAPI.delete(snapshot.data[index].id);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyApp()),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                    return card;
                  });
            } else
              return CircularProgressIndicator();
          }),
    );
  }
}
