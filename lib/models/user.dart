
class User {
  int id;
  String fullname;
  String email;


  
  User({this.id,this.fullname,this.email});

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json["id"] as int,
      fullname: json["fullname"] as String,
      email: json["email"] as String,
     
    );
  }


Map<String, dynamic> toJson(){
  return {
    "id": id,
    "fullname": fullname,
    "email":email,
  };
}
}