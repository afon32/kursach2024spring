import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:postgres/postgres.dart';
import 'package:sql_test_app/pages/buys/user_buys_page.dart';
import 'package:sql_test_app/utils/utils.dart';
import 'package:sql_test_app/widgets/app_bar.dart';
import 'package:sql_test_app/widgets/buy_info.dart';
import 'package:sql_test_app/widgets/user_info.dart';

class SelectBuysGroupController extends GetxController {
  List family = [];
  bool isDownload = false;
  String ownerID = 'a';
  Future getFamily() async {
    String familyMembersList = '';
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
    print(ownerID);
    //final userSearching = await conn.execute("SELECT * FROM AppUser WHERE (user_id = $ownerID)");
    final result2 = await conn.execute(
        "SELECT family_member_id FROM Family WHERE (family_owner_id = $ownerID);");
    print(result2);
    family = result2;
    print('\n $family \n');

    familyMembersList = '${family[0][0]}';
    if (family.length > 1) {
      for (int i = 1; i < family.length; i++) {
        familyMembersList = '$familyMembersList, ${family[i][0]}';
      }
    }
    print('\n');
    print(familyMembersList);
    print('\n');

    final result3 = await conn.execute(
        "SELECT * FROM AppUser WHERE user_id IN ($familyMembersList);");

    family = result3;
    //family.add(userSearching[0]);
    print(family);
    conn.close();
    isDownload = true;
  }

  Widget sss(prop) {
    if (!prop) {
      return const Center(
          child: CircularProgressIndicator(
        color: Colors.green,
      ));
    } else {
      return GridView.builder(
          itemCount: family.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemBuilder: (context, index) {
            return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                    highlightColor: Colors.black.withOpacity(0.1),
                    //splashColor: Colors.transparent,
                    borderRadius: BorderRadius.circular(15.0),
                    child: Container(
                        height: MediaQuery.sizeOf(context).height * 0.2,
                        width: MediaQuery.sizeOf(context).width * 0.29,
                        decoration: BoxDecoration(
                          //color: Color.fromARGB(255, 105, 105, 105),
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: const <BoxShadow>[
                            BoxShadow(
                                color: Color.fromARGB(255, 105, 105, 105),
                                blurRadius: 25.0,
                                offset: Offset(0.0, 0.75))
                          ],
                        ),
                        child: Center(
                            child: Padding(
                                padding: EdgeInsets.only(
                                  top: MediaQuery.sizeOf(context).height * 0.03,
                                ),
                                child: Column(children: [
                                  Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size:
                                        MediaQuery.sizeOf(context).width * 0.2,
                                  ),
                                  Text(family[index][1],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Times New Roman',
                                          fontSize: 20.0)),
                                ])))),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UserBuysPage(),
                              settings: RouteSettings(
                                  arguments: [family[index][0], false])));
                    }));
          });
    }
  }

  Widget grid(context) {
    return Scaffold(
        // backgroundColor: const Color.fromARGB(255, 240, 193, 26),
        backgroundColor: Color.fromARGB(255, 73, 76, 83),
        appBar: appBar(context),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          highlightColor: Colors.black.withOpacity(0.1),
                          //splashColor: Colors.transparent,
                          borderRadius: BorderRadius.circular(15.0),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const UserBuysPage(),
                                    settings: RouteSettings(arguments: [
                                      int.parse(ownerID),
                                      true
                                    ])));
                          },
                          child: Padding(
                              padding: EdgeInsets.all(
                                  MediaQuery.sizeOf(context).height * 0.01),
                              child: Container(
                                height: MediaQuery.sizeOf(context).height * 0.2,
                                width: MediaQuery.sizeOf(context).width * 0.55,
                                decoration: BoxDecoration(
                                  //color: Color.fromARGB(255, 105, 105, 105),
                                  color: Color.fromARGB(255, 58, 237, 64),
                                  borderRadius: BorderRadius.circular(15.0),
                                  boxShadow: const <BoxShadow>[
                                    BoxShadow(
                                        color:
                                            Color.fromARGB(255, 105, 105, 105),
                                        blurRadius: 25.0,
                                        offset: Offset(0.0, 0.75))
                                  ],
                                ),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 15.0),
                                        child: Icon(
                                          Icons.groups,
                                          color: Colors.white,
                                          size:
                                              MediaQuery.sizeOf(context).width *
                                                  0.2,
                                        ),
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.only(right: 15.0),
                                          child: Text('Общие',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Times New Roman',
                                                  fontSize: 20.0)))
                                    ]),
                              ))),

                      InkWell(
                          highlightColor: Colors.black.withOpacity(0.1),
                          //splashColor: Colors.transparent,
                          borderRadius: BorderRadius.circular(15.0),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const UserBuysPage(),
                                    settings: RouteSettings(arguments: [
                                      int.parse(ownerID),
                                      false
                                    ])));
                          },
                          child: Padding(
                              padding: EdgeInsets.all(
                                  MediaQuery.sizeOf(context).height * 0.01),
                              child: Container(
                                height: MediaQuery.sizeOf(context).height * 0.2,
                                width: MediaQuery.sizeOf(context).width * 0.29,
                                decoration: BoxDecoration(
                                  //color: Color.fromARGB(255, 105, 105, 105),
                                  color: const Color.fromARGB(255, 58, 237, 64),
                                  borderRadius: BorderRadius.circular(15.0),
                                  boxShadow: const <BoxShadow>[
                                    BoxShadow(
                                        color:
                                            Color.fromARGB(255, 105, 105, 105),
                                        blurRadius: 25.0,
                                        offset: Offset(0.0, 0.75))
                                  ],
                                ),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        Icons.settings_accessibility,
                                        color: Colors.white,
                                        size: MediaQuery.sizeOf(context).width *
                                            0.11,
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.only(right: 15.0),
                                          child: Text('Мои',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Times New Roman',
                                                  fontSize: 20.0)))
                                    ]),
                              ))),
                      // Container(
                      //   width: MediaQuery.of(context).size.width * 0.6,
                      //   height: MediaQuery.of(context).size.height * 0.2,
                      //   decoration: BoxDecoration(
                      //     color: Colors.orange,
                      //     borderRadius: BorderRadius.circular(10.0),
                      //     border: Border.all(color: Colors.black),
                      //   ),
                      //   child: Center(
                      //     child: Text('Общие расходы'),
                      //   ),
                      // ),
                      // InkWell(
                      //   onTap: () {
                      //     Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) => const UserBuysPage(),
                      //             settings: RouteSettings(
                      //                 arguments: [int.parse(ownerID), true])));
                      //   },
                      //   child: Container(
                      //     width: MediaQuery.of(context).size.width * 0.34,
                      //     height: MediaQuery.of(context).size.height * 0.2,
                      //     decoration: BoxDecoration(
                      //       color: Colors.orange,
                      //       borderRadius: BorderRadius.circular(10.0),
                      //       border: Border.all(color: Colors.black),
                      //     ),
                      //     child: Center(
                      //       child: Text('Мои расходы'),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height * 0.65,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.black),
                      ),
                      // child: SingleChildScrollView(
                      //   scrollDirection: Axis.vertical,
                      child: Column(children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.05,
                          child: Center(
                            child: Text('По членам семьи',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Times New Roman',
                                    fontSize: 20.0)),
                          ),
                        ),
                        Container(
                            height: MediaQuery.of(context).size.height * 0.58,
                            child: sss(isDownload)
                            // GridView.builder(
                            //     itemCount: family.length,
                            //     gridDelegate:
                            //         const SliverGridDelegateWithFixedCrossAxisCount(
                            //             crossAxisCount: 2),
                            //     itemBuilder: (context, index) {
                            //       return Padding(
                            //           padding: const EdgeInsets.all(8.0),
                            //           child: InkWell(
                            //               highlightColor:
                            //                   Colors.black.withOpacity(0.1),
                            //               //splashColor: Colors.transparent,
                            //               borderRadius:
                            //                   BorderRadius.circular(15.0),
                            //               child: Container(
                            //                   height: MediaQuery.sizeOf(context)
                            //                           .height *
                            //                       0.2,
                            //                   width: MediaQuery.sizeOf(context)
                            //                           .width *
                            //                       0.29,
                            //                   decoration: BoxDecoration(
                            //                     //color: Color.fromARGB(255, 105, 105, 105),
                            //                     color: Colors.green,
                            //                     borderRadius:
                            //                         BorderRadius.circular(15.0),
                            //                     boxShadow: const <BoxShadow>[
                            //                       BoxShadow(
                            //                           color: Color.fromARGB(
                            //                               255, 105, 105, 105),
                            //                           blurRadius: 25.0,
                            //                           offset: Offset(0.0, 0.75))
                            //                     ],
                            //                   ),
                            //                   child: Center(
                            //                       child: Padding(
                            //                           padding: EdgeInsets.only(
                            //                             top: MediaQuery.sizeOf(
                            //                                         context)
                            //                                     .height *
                            //                                 0.03,
                            //                           ),
                            //                           child: Column(children: [
                            //                             Icon(
                            //                               Icons.person,
                            //                               color: Colors.white,
                            //                               size: MediaQuery.sizeOf(
                            //                                           context)
                            //                                       .width *
                            //                                   0.2,
                            //                             ),
                            //                             Text(family[index][1],
                            //                                 style: TextStyle(
                            //                                     color: Colors
                            //                                         .white,
                            //                                     fontFamily:
                            //                                         'Times New Roman',
                            //                                     fontSize:
                            //                                         20.0)),
                            //                           ])))),
                            //               onTap: () {
                            //                 Navigator.push(
                            //                     context,
                            //                     MaterialPageRoute(
                            //                         builder: (context) =>
                            //                             const UserBuysPage(),
                            //                         settings: RouteSettings(
                            //                             arguments: [
                            //                               family[index][0],
                            //                               false
                            //                             ])));
                            //               }));
                            //     })
                            ),
                      ])),
                ]))));
  }
}
