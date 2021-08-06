
import 'package:flutter/material.dart';
import 'package:laravelcrudapi/main.dart';

import 'apis/userapi.dart';
import 'models/user.dart';



// ignore: must_be_immutable
class UserDetailPage extends StatefulWidget{
  int id;
  UserDetailPage({Key key ,this.id}):super(key: key);
  @override 
  State<StatefulWidget> createState(){
    return UserDetailPageState();
  }

}

class UserDetailPageState extends State<UserDetailPage>{
  @override 
  Widget build(BuildContext context){
    var userAPI =new  UserAPI();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title:Text("Crud with Flutter API"),),
        body: Padding (
      padding:EdgeInsets.all(10),
      child: FutureBuilder(
        future: userAPI.find(widget.id),
        builder:(context, AsyncSnapshot<User> snapshot){
          if(snapshot.hasData){
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(snapshot.data.id.toString()),
                  Padding(padding: EdgeInsets.all(10)),
                  Text(snapshot.data.fullname),
                  Padding(padding: EdgeInsets.all(10)),
                  Text(snapshot.data.email),
                  Padding(padding: EdgeInsets.all(10)),
                  SizedBox(
                    width:double.infinity,
                    child:ElevatedButton(
                      child:Text("Back"),
                      onPressed:(){
                         Navigator.push(
                           context, 
                           MaterialPageRoute(builder: (context)=>MyApp()),
                           );
                      }
                    )

                  )

                ],
              );
          }
          else
          return CircularProgressIndicator();
        }),
     ),
    )
    );
  }
}

