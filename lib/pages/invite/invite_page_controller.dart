import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:postgres/postgres.dart';

class InvitePageController extends GetxController {
  final invitePageController = GlobalKey<FormState>();
  String ownerID = 'a';
  String userName = 'a';
  List ll = [];

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
    ll = result2;
    print('AAAAAAAAAAA  $ll AAAAAAAAAAAAAAAA');
    //return result2;
  }

  Future sendInvitation(String username, recieverID) async{
    final conn = await Connection.open(
        Endpoint(
            host: '94.198.220.56',
            port: 5430,
            database: 'afon32kursach',
            username: 'postgres',
            password: 'afanas228'),
        settings: const ConnectionSettings(sslMode: SslMode.disable));
    
    await conn.execute("INSERT INTO Invitation(invitation_from, invitation_to, invitation_role, invitation_date) VALUES($ownerID, $recieverID, 'Сын', NULL)");
    conn.close();
    print('\n \n \n');
    print('vse oks');
    print('\n \n \n');
  }

  Widget list() {
    //getDataAboutUser();
    //final result2 = getDataAboutUser() as Result;
    //getDataAboutUser();
    return (ListView.builder(
      itemCount: ll.length,
      itemBuilder: (BuildContext context, int index) {
        //return Text(ll[index][1].toString(), style: TextStyle(fontSize: 22),);
        return Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: Colors.green),
                
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(ll[index][1].toString(),
                          style: const TextStyle(fontSize: 22)),
                      IconButton(onPressed: () {sendInvitation(ll[index][1], ll[index][0]);}, icon: const Icon(Icons.person_add_alt_1_rounded))
                    ])));
      },
    ));
  }
}
