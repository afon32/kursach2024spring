import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';
import 'package:sql_test_app/utils/utils.dart';

String ownerID = 'a';
String ownerName = 'a';
bool isDownload = false;
List res = [];

Future createFamily(owner, role) async {
  final conn = await Connection.open(
      Endpoint(
          host: '94.198.220.56',
          port: 5430,
          database: 'afon32kursach',
          username: 'postgres',
          password: 'afanas228'),
      settings: const ConnectionSettings(sslMode: SslMode.disable));

  await conn.execute(
      "INSERT INTO Family(family_owner_id, family_member_id, family_member_role) VALUES($owner, $ownerID, '$role'); ");
  conn.close();
  print('created family');
}

Future deleteInvitation(owner) async {
  final conn = await Connection.open(
      Endpoint(
          host: '94.198.220.56',
          port: 5430,
          database: 'afon32kursach',
          username: 'postgres',
          password: 'afanas228'),
      settings: const ConnectionSettings(sslMode: SslMode.disable));

  await conn.execute(
      "DELETE FROM Invitation WHERE invitation_from = $owner AND invitation_to = $ownerID");
  conn.close();
  print('deleted');
}

Future getDataAboutUser() async {
  final conn = await Connection.open(
      Endpoint(
          host: '94.198.220.56',
          port: 5430,
          database: 'afon32kursach',
          username: 'postgres',
          password: 'afanas228'),
      settings: const ConnectionSettings(sslMode: SslMode.disable));
  print('after conn');
  final result = await conn.execute(
      "SELECT user_id FROM AppUser WHERE user_login = '${FirebaseAuth.instance.currentUser!.email}'");
  ownerID = result[0][0].toString();
  print(ownerID);
  final result2 = await conn.execute(
      "SELECT invitation_from, invitation_role FROM Invitation WHERE invitation_to = $ownerID");
  print(result2);
  if (!result2.isEmpty) {
    final result3 = await conn.execute(
        "SELECT user_name FROM AppUser WHERE (user_id = ${result2[0][0]})");
    ownerName = result3[0][0].toString();
    print(result3);
  }
  conn.close();

  res = result2;

  print(res);
  isDownload = true;
}

Widget sss(prop) {
  if (!prop) {
    return const Center(
        child: CircularProgressIndicator(
      color: Colors.green,
    ));
  } else {
    return ListView.builder(
      itemCount: res.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
            padding: const EdgeInsets.all(5.0),
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
                          Text(
                            ownerName,
                          ),
                          Text(
                            res[index][1].toString(),
                          ),
                          IconButton(
                              onPressed: () {
                                createFamily(res[index][0], res[index][1]);
                                deleteInvitation(res[index][0]);
                                Navigator.of(context).pop();
                                Utils.showGreenSnackBar('Приглашение принято!');
                              },
                              icon: const Icon(Icons.person_add_alt_1_rounded))
                        ]))));
      },
    );
  }
}

void showInvitations(BuildContext context) {
  isDownload = false;
  res = [];
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return FutureBuilder(
            future: getDataAboutUser(),
            builder: (context, snapshot) => AlertDialog(
                  backgroundColor: Color.fromARGB(255, 73, 76, 83),
                  title: const Text('Приглашения',
                      style: TextStyle(color: Colors.green)),
                  content: SingleChildScrollView(
                      child: Container(
                    height: MediaQuery.sizeOf(context).height * 0.3,
                    width: MediaQuery.sizeOf(context).width * 0.5,
                    child: sss(isDownload),
                    // ListView.builder(
                    //   itemCount: res.length,
                    //   itemBuilder: (BuildContext context, int index) {
                    //     return Padding(
                    //         padding: const EdgeInsets.all(5.0),
                    //         child: Container(
                    //             decoration: BoxDecoration(
                    //                 borderRadius: BorderRadius.circular(5.0),
                    //                 color: Colors.green),
                    //             height: Utils.categorySize,
                    //             child: Padding(
                    //                 padding: EdgeInsets.all(5.0),
                    //                 child: Row(
                    //                     mainAxisAlignment:
                    //                         MainAxisAlignment.spaceBetween,
                    //                     children: [
                    //                       Text(
                    //                         ownerName,
                    //                       ),
                    //                       Text(
                    //                         res[index][1].toString(),
                    //                       ),
                    //                       IconButton(
                    //                           onPressed: () {
                    //                             createFamily(res[index][0],
                    //                                 res[index][1]);
                    //                             deleteInvitation(res[index][0]);
                    //                           },
                    //                           icon: const Icon(Icons
                    //                               .person_add_alt_1_rounded))
                    //                     ]))));
                    //   },
                    // ),
                  )),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Закрыть',
                          style: TextStyle(color: Colors.green)),
                    ),
                  ],
                ));
      });
}
