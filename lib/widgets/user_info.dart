import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:postgres/postgres.dart';
import 'package:sql_test_app/data/user.dart';

Userr ourUser =
    Userr(email: 'wait...', name: 'wait...', post: 'wait...', level: 'wait...');

String userID = 'wait...';
String userName = 'wait...';
final res = getDataAboutUser();

Future getDataAboutUser() async {
  final conn = await Connection.open(
      Endpoint(
          host: '94.198.220.56',
          port: 5430,
          database: 'afon32kursach',
          username: 'postgres',
          password: 'afanas228'),
      settings: const ConnectionSettings(sslMode: SslMode.disable));

  final result = await conn.execute(
      "SELECT user_id, user_name FROM AppUser WHERE user_login = '${FirebaseAuth.instance.currentUser!.email}'");
  userID = result[0][0].toString();
  userName = result[0][1].toString();
  conn.close();
  return result;
}

Stream<List<Userr>> readUsers() => FirebaseFirestore.instance
    .collection('users')
    .snapshots()
    .map((snapshot) => snapshot.docs.map((doc) {
          Map<String, dynamic> data = doc.data();
          data['id'] = doc.id;
          //print(data['post']);
          return Userr.fromJson(data);
        }).toList());

Future searchUser() async {
  List<Userr> users = await readUsers().first;
  if (users.isNotEmpty) {
    for (Userr user in users) {
      if (user.email == FirebaseAuth.instance.currentUser!.email) {
        //print('${user.name}  ${user.email}, ${user.post}');
        //return user;
        ourUser = user;
      }
    }
  }
}

Widget ss(prop) {
  if (prop == 'wait...') {
    return const Center(child: CircularProgressIndicator(color: Colors.green,));
  } else {
    return Text('$prop' , style: TextStyle(color: Colors.white));
  }
}

void userInfo(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return FutureBuilder(
            future: getDataAboutUser(),
            builder: (context, snapshot) {
              // if (snapshot.hasData){
              return AlertDialog(
                backgroundColor: Color.fromARGB(255, 73, 76, 83),
                title: const Text('Пользователь' , style: TextStyle(color: Colors.white)),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [const Text('ID:', style: TextStyle(color: Colors.white),), ss(userID)],
                          )),
                      //Text('ID: ${userID}')),
                      Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [const Text('Имя:', style: TextStyle(color: Colors.white)), ss(userName)],
                          )),
                      
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Закрыть' , style: TextStyle(color: Colors.white)),
                  ),
                ],
              );
              // }
              // else {
              //   return CircularProgressIndicator();
              // }
            });
      });
}
