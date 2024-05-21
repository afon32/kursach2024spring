class Userr{
  String id;
  final String email;
  final String name;
  final String post;
  final String level;


  Userr({
    this.id = '',
    required this.email,
    required this.name,
    required this.post,
    required this.level,
  });


   Map<String, dynamic> toJson() => {
    'id':id,
    'email': email,
    'username': name,
    'post' : post,
    'level' : level,
   };

 static Userr fromJson(Map<String, dynamic> json) => Userr(
    id: json['id'],
    email: json['email'],
    name: json['username'],
    post: json['post'],
    level: json['level'],
 );
   
}