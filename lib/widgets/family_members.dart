import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:postgres/postgres.dart';
import 'package:sql_test_app/data/user.dart';
import 'package:sql_test_app/pages/invite/invite_page.dart';
import 'package:sql_test_app/utils/utils.dart';
import 'package:sql_test_app/widgets/send_invitations.dart';

Userr ourUser =
    Userr(email: 'wait...', name: 'wait...', post: 'wait...', level: 'wait...');
bool isDownload = false;
String userID = 'wait...';
String userName = 'wait...';
List familyMembers = [];
final res = getDataAboutUser();

Future getDataAboutUser() async {
  familyMembers = [];
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

  final result2 = await conn.execute(
      "SELECT family_member_id, family_member_role FROM Family WHERE(family_owner_id = $userID)");
  for (List user in result2) {
    final result3 = await conn
        .execute("SELECT user_name FROM AppUser WHERE (user_id = ${user[0]})");
    familyMembers.add([result3[0][0], user[1]]);
  }
  print(familyMembers);
  conn.close();
  isDownload = true;
  return result;
}

Widget sss(prop) {
  if (!prop) {
    return const Center(
        child: CircularProgressIndicator(
      color: Colors.green,
    ));
  } else {
    return ListView.builder(
      itemCount: familyMembers.length,
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
                    Text(familyMembers[index][0].toString()),
                    Text(familyMembers[index][1].toString())
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

void familyInfo(BuildContext context) {
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
                title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Семья', style: TextStyle(color: Colors.white)),
                      IconButton(
                          onPressed: () {
                            sendInvitations(context);
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => const InvitePage(),
                            //     ));
                          },
                          icon: Icon(
                            Icons.person_add_alt_1,
                            color: Colors.greenAccent,
                            size: 30.0,
                          ))
                    ]),
                content: SingleChildScrollView(
                    child: Container(
                        width: MediaQuery.sizeOf(context).width * 0.5,
                        height: MediaQuery.sizeOf(context).height * 0.3,
                        child: sss(isDownload)
                        // ListView.builder(
                        //   itemCount: familyMembers.length,
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
                        //                 Text(
                        //                     familyMembers[index][0].toString()),
                        //                 Text(familyMembers[index][1].toString())
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
