import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:postgres/postgres.dart';
import 'package:sql_test_app/data/user.dart';
import 'package:sql_test_app/pages/invite/invite_page.dart';
import 'package:sql_test_app/utils/utils.dart';

Userr ourUser =
    Userr(email: 'wait...', name: 'wait...', post: 'wait...', level: 'wait...');

final selectedRole = TextEditingController();
bool isDownload = false;
String userID = 'wait...';
String userName = 'wait...';
List familyMembers = [];
List usersForInvitation = [];
String ownerID = 'a';
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
      "SELECT user_id FROM AppUser WHERE user_login = '${FirebaseAuth.instance.currentUser!.email}'");
  ownerID = result[0][0].toString();
  print('\n\n\n $ownerID \n\n\n');

  final result2 = await conn.execute(
      "SELECT user_id, user_name FROM AppUser au WHERE NOT EXISTS(SELECT 1 FROM Family f WHERE f.family_owner_id = $ownerID AND f.family_member_id = au.user_id) AND NOT EXISTS(SELECT 1 FROM Invitation i WHERE i.invitation_from = $ownerID AND i.invitation_to = au.user_id) AND au.user_id != $ownerID;");

  conn.close();
  usersForInvitation = result2;
  print(usersForInvitation);
  //return result2;
  isDownload = true;
}

Future sendInvitation(recieverID, invitation_role) async {
  final conn = await Connection.open(
      Endpoint(
          host: '94.198.220.56',
          port: 5430,
          database: 'afon32kursach',
          username: 'postgres',
          password: 'afanas228'),
      settings: const ConnectionSettings(sslMode: SslMode.disable));

  await conn.execute(
      "INSERT INTO Invitation(invitation_from, invitation_to, invitation_role, invitation_date) VALUES($ownerID, $recieverID, '$invitation_role', NULL)");
  conn.close();
  print('\n \n \n');
  print('vse oks');
  print('\n \n \n');
}

// Future getDataAboutUser() async {
//   familyMembers = [];
//   final conn = await Connection.open(
//       Endpoint(
//           host: '94.198.220.56',
//           port: 5430,
//           database: 'afon32kursach',
//           username: 'postgres',
//           password: 'afanas228'),
//       settings: const ConnectionSettings(sslMode: SslMode.disable));

//   final result = await conn.execute(
//       "SELECT user_id, user_name FROM AppUser WHERE user_login = '${FirebaseAuth.instance.currentUser!.email}'");
//   userID = result[0][0].toString();
//   userName = result[0][1].toString();

//   final result2 = await conn.execute(
//       "SELECT family_member_id, family_member_role FROM Family WHERE(family_owner_id = $userID)");
//   for (List user in result2) {
//     final result3 = await conn
//         .execute("SELECT user_name FROM AppUser WHERE (user_id = ${user[0]})");
//     familyMembers.add([result3[0][0], user[1]]);
//   }
//   print(familyMembers);
//   conn.close();
//   return result;
// }

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

Widget sss(prop) {
  if (!prop) {
    return const Center(
        child: CircularProgressIndicator(
      color: Colors.green,
    ));
  } else {
    return ListView.builder(
      itemCount: usersForInvitation.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.all(5.0),
          child: InkWell(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.green),
              height: Utils.categorySize,
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(usersForInvitation[index][1].toString()),
                    IconButton(
                        onPressed: () {
                          selectCategory(context, usersForInvitation[index][0]);
                          // sendInvitation();
                          // Utils.showGreenSnackBar('Приглашение отправлено!');
                          // Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.person_add_alt_1,
                          color: Colors.greenAccent,
                          size: 30.0,
                        ))
                    //Text(usersForInvitation[index][1].toString())
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget ss(prop) {
  if (prop == 'wait...') {
    return const Center(child: CircularProgressIndicator());
  } else {
    return Text('$prop', style: TextStyle(color: Colors.white));
  }
}

void selectCategory(BuildContext context, userID) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 73, 76, 83),
          title: Center(
              child: Text('Выбор роли',
                  style: const TextStyle(fontSize: 15, color: Colors.white))),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  style: TextStyle(fontSize: 15, color: Colors.white),
                  controller: selectedRole,
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                      label: Text(
                        'Роль',
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                      prefixIcon: Icon(
                        Icons.group,
                        color: Colors.white,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      )),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.8,
                        child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll<Color>(Colors.green),
                            ),
                            onPressed: () {
                              if (selectedRole.text.isEmpty) {
                                Utils.showRedSnackBar('Введите роль!');
                              } else {
                                sendInvitation(userID, selectedRole.text);
                                Utils.showGreenSnackBar(
                                    'Приглашение отправлено!');
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              }
                            },
                            child: const Text('Отправить')))),
              ],
            ),
          ),
        );
      });
}

void sendInvitations(BuildContext context) {
  isDownload = false;
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return FutureBuilder(
            future: getDataAboutUser(),
            builder: (context, snapshot) {
              // if (snapshot.hasData){
              return AlertDialog(
                backgroundColor: Color.fromARGB(255, 73, 76, 83),
                title:
                    Text('Пригласить', style: TextStyle(color: Colors.white)),
                content: SingleChildScrollView(
                    child: Container(
                        width: MediaQuery.sizeOf(context).width * 0.5,
                        height: MediaQuery.sizeOf(context).height * 0.3,
                        child: sss(isDownload)
                        // ListView.builder(
                        //   itemCount: usersForInvitation.length,
                        //   itemBuilder: (context, index) {
                        //     return Padding(
                        //       padding: EdgeInsets.all(5.0),
                        //       child: InkWell(
                        //         child: Container(
                        //           decoration: BoxDecoration(
                        //               borderRadius: BorderRadius.circular(5.0),
                        //               color: Colors.green),
                        //           height: Utils.categorySize,
                        //           child: Padding(
                        //             padding: EdgeInsets.all(5.0),
                        //             child: Row(
                        //               mainAxisAlignment:
                        //                   MainAxisAlignment.spaceBetween,
                        //               children: [
                        //                 Text(usersForInvitation[index][1]
                        //                     .toString()),
                        //                 IconButton(
                        //                     onPressed: () {
                        //                       sendInvitation(
                        //                           usersForInvitation[index][0]);
                        //                       Utils.showGreenSnackBar(
                        //                           'Приглашение отправлено!');
                        //                       Navigator.of(context).pop();
                        //                     },
                        //                     icon: const Icon(
                        //                       Icons.person_add_alt_1,
                        //                       color: Colors.greenAccent,
                        //                       size: 30.0,
                        //                     ))
                        //                 //Text(usersForInvitation[index][1].toString())
                        //               ],
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //     );
                        //   },
                        // )
                        )
                    // ListBody(
                    //   children: <Widget>[
                    //     Padding(
                    //         padding: const EdgeInsets.all(5.0),
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             const Text(
                    //               'ID:',
                    //               style: TextStyle(color: Colors.white),
                    //             ),
                    //             ss(userID)
                    //           ],
                    //         )),
                    //     //Text('ID: ${userID}')),
                    //     Padding(
                    //         padding: const EdgeInsets.all(5.0),
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             const Text('Имя:',
                    //                 style: TextStyle(color: Colors.white)),
                    //             ss(userName)
                    //           ],
                    //         )),
                    //   ],
                    // ),
                    ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Закрыть',
                        style: TextStyle(color: Colors.white)),
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
