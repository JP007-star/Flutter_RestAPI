import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:laravelcrudapi/models/user.dart';

class UserAPI {
  String baseurl = "http://127.0.0.1:8000/api";
  Future<List<User>> findAll() async {
    var response = await http.get(new Uri.http("10.0.2.2:8000", "/api"));
    print(response.statusCode);
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception("Failed to upload product list");
    }
  }

  Future<User> find(int id) async {
    var response =
        await http.get(new Uri.http("10.0.2.2:8000", "/api/show/$id"));
    if (response.statusCode == 200) {
      // print(json.decode(response.body));
      return User.fromJson(jsonDecode(response.body));
      
    } else {
      throw Exception('Failed to create album.');
    }
  }
  Future<User> edit(int id) async {
    var response =
        await http.get(new Uri.http("10.0.2.2:8000", "/api/show/$id"));
    if (response.statusCode == 200) {
       //print(json.decode(response.body));
      return User.fromJson(jsonDecode(response.body));
      
    } else {
      throw Exception('Failed to create album.');
    }
  }
  
  Future<User> create(User user) async {
  String body = json.encode(user.toJson());
  final response = await http.post(new Uri.http("10.0.2.2:8000", "/api/store"),
    headers: {"Content-Type": "application/json"},
    body: body,
  );

   if (response.statusCode == 200) {
      print(body);
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create album.');
    }
  }
  Future<User> delete(int id) async {
    var response =
        await http.post(new Uri.http("10.0.2.2:8000", "/api/delete/$id"));
    if (response.statusCode == 200) {
       print(id);
      return User.fromJson(jsonDecode(response.body));
      
    } else {
      throw Exception('Failed to create album.');
    }
}
}
