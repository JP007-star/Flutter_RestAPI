
import 'package:flutter/material.dart';
import 'package:laravelcrudapi/main.dart';
import 'package:laravelcrudapi/models/user.dart';

import 'apis/userapi.dart';

// ignore: must_be_immutable
class AddUserDetailPage extends StatefulWidget {
  AddUserDetailPage(User json);
  
  @override
  State<StatefulWidget> createState() {
    return AddUserDetailPageState();
  }
}

class AddUserDetailPageState extends State<AddUserDetailPage> {
  TextEditingController textEditingControllerName;
  TextEditingController textEditingControllerEmail;
  User user;
  @override
  void initState() {
    super.initState();
    textEditingControllerName = new TextEditingController();
    textEditingControllerEmail = new TextEditingController();
    user = new User();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              title: Text("Add Product"),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(children: [
                  TextFormField(
                    controller: textEditingControllerName,
                    decoration: InputDecoration(
                      hintText: "Name",
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        user.fullname = newValue;
                      });
                    },
                  ),
                  TextFormField(
                    controller: textEditingControllerEmail,
                    decoration: InputDecoration(
                      hintText: "Email id",
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        user.email = newValue;
                      });
                    },
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            var userAPI = new UserAPI();
                            await userAPI.create(user);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MyApp()),
                            );
                          },
                          child: Text("Save"),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MyApp()),
                            );
                          },
                          child: Text("Cancel"),
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            )));
  }
}
