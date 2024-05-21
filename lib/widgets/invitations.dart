import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

String ownerID = 'a';
String ownerName = 'a';
List res = [];

Future createFamily(owner, role) async {
  final conn = await Connection.open(
      Endpoint(
          host: '94.198.220.56',
          port: 5430,
          database: 'afon32kursach',
          username: 'postgres',
          password: 'afanas228'),
      settings: ConnectionSettings(sslMode: SslMode.disable));

  await conn.execute(
      "INSERT INTO Family(family_owner_id, family_member_id, family_member_role) VALUES($owner, $ownerID, '$role'); ");
  conn.close();
}

Future deleteInvitation(owner) async {
  final conn = await Connection.open(
      Endpoint(
          host: '94.198.220.56',
          port: 5430,
          database: 'afon32kursach',
          username: 'postgres',
          password: 'afanas228'),
      settings: ConnectionSettings(sslMode: SslMode.disable));

  await conn.execute(
      "DELETE FROM Invitation WHERE invitation_from = ${owner} AND invitation_to = ${ownerID}");
  conn.close();
}

Future getDataAboutUser() async {
  final conn = await Connection.open(
      Endpoint(
          host: '94.198.220.56',
          port: 5430,
          database: 'afon32kursach',
          username: 'postgres',
          password: 'afanas228'),
      settings: ConnectionSettings(sslMode: SslMode.disable));

  final result = await conn.execute(
      "SELECT user_id FROM AppUser WHERE user_login = '${FirebaseAuth.instance.currentUser!.email}'");
  ownerID = result[0][0].toString();
  final result2 = await conn.execute(
      "SELECT invitation_from, invitation_role FROM Invitation WHERE invitation_to = $ownerID");
  final result3 = await conn.execute(
      "SELECT user_name FROM AppUser WHERE user_id = ${result2[0][0]}");
  conn.close();
  res = result2;
  ownerName = result3[0][0].toString();
}

void showInvitations(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return FutureBuilder(
            future: getDataAboutUser(),
            builder: (context, snapshot) => Scaffold(
                    body: AlertDialog(
                  title: Text('Приглашения'),
                  content: ListView.builder(
                    itemCount: res.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: Colors.green),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(ownerName,
                                        style: TextStyle(fontSize: 22)),
                                    Text(res[index][1].toString(),
                                        style: TextStyle(fontSize: 22)),
                                    IconButton(
                                        onPressed: () {
                                          createFamily(
                                              res[index][0], res[index][1]);
                                          deleteInvitation(res[index][0]);
                                        },
                                        icon: const Icon(
                                            Icons.person_add_alt_1_rounded))
                                  ])));
                    },
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Закрыть'),
                    ),
                  ],
                )));
      });
}
