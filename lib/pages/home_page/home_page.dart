import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sql_test_app/pages/home_page/home_page_controller.dart';
import 'package:sql_test_app/widgets/app_bar.dart';
import 'package:sql_test_app/widgets/family_members.dart';
import 'package:sql_test_app/widgets/user_info.dart';

class UserHomePage extends StatelessWidget {
  const UserHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserHomePageController>(
        init: UserHomePageController(),
        initState: (_) {},
        builder: (_) {
          return Scaffold(
              // backgroundColor: const Color.fromARGB(255, 240, 193, 26),
              backgroundColor: Color.fromARGB(255, 73, 76, 83),
              appBar: appBar(context),
              body: 
              SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                                highlightColor: Colors.black.withOpacity(0.1),
                                //splashColor: Colors.transparent,
                                borderRadius: BorderRadius.circular(15.0),
                                onTap: () {
                                  userInfo(context);
                                },
                                child: Padding(
                                    padding: EdgeInsets.all(
                                        MediaQuery.sizeOf(context).height *
                                            0.01),
                                    child: Container(
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              0.1,
                                      width: MediaQuery.sizeOf(context).height *
                                          0.2,
                                      decoration: BoxDecoration(
                                        //color: Color.fromARGB(255, 105, 105, 105),
                                        color: Colors.green,
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        boxShadow: const <BoxShadow>[
                                          BoxShadow(
                                              color: Color.fromARGB(
                                                  255, 105, 105, 105),
                                              blurRadius: 25.0,
                                              offset: Offset(0.0, 0.75))
                                        ],
                                      ),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(
                                              Icons.person,
                                              color: Colors.white,
                                              size: MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.05,
                                            ),
                                            const Padding(
                                                padding: EdgeInsets.only(
                                                    right: 15.0),
                                                child: Text('User Info',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily:
                                                            'Times New Roman',
                                                        fontSize: 20.0)))
                                          ]),
                                    ))),
//////////////////////////////////////////////////////////////////////
                            InkWell(
                                highlightColor: Colors.black.withOpacity(0.1),
                                //splashColor: Colors.transparent,
                                borderRadius: BorderRadius.circular(15.0),
                                onTap: () {
                                  familyInfo(context);
                                },
                                child: Padding(
                                    padding: EdgeInsets.all(
                                        MediaQuery.sizeOf(context).height *
                                            0.01),
                                    child: Container(
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              0.1,
                                      width: MediaQuery.sizeOf(context).height *
                                          0.1,
                                      decoration: BoxDecoration(
                                        //color: Color.fromARGB(255, 105, 105, 105),
                                        color: Colors.green,
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        boxShadow: const <BoxShadow>[
                                          BoxShadow(
                                              color: Color.fromARGB(
                                                  255, 105, 105, 105),
                                              blurRadius: 25.0,
                                              offset: Offset(0.0, 0.75))
                                        ],
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.group,
                                          color: Colors.white,
                                          size: MediaQuery.sizeOf(context)
                                                  .height *
                                              0.05,
                                        ),
                                      ),
                                    ))),
                          ],
                        )),
                    Container(
                      height: MediaQuery.sizeOf(context).height * 0.23,
                      child: Image.asset(
                        'assets/azlogo.jpg',
                        fit: BoxFit.contain,
                      ),
                    ),
                    Padding(
                      //padding: EdgeInsets.all(10.0),
                      padding: EdgeInsets.only(
                          top: MediaQuery.sizeOf(context).height * 0.05),
                      child: InkWell(
                          highlightColor: Colors.black.withOpacity(0.1),
                          //splashColor: Colors.transparent,
                          borderRadius: BorderRadius.circular(15.0),
                          onTap: () {
                            _.addBuy(context);
                          },
                          child: Padding(
                              padding: EdgeInsets.all(
                                  MediaQuery.sizeOf(context).height * 0.01),
                              child: Container(
                                height: MediaQuery.sizeOf(context).height * 0.2,
                                width: MediaQuery.sizeOf(context).width * 0.8,
                                decoration: BoxDecoration(
                                  //color: Color.fromARGB(255, 105, 105, 105),
                                  color: Colors.green,
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
                                      const Padding(
                                          padding: EdgeInsets.all(15.0),
                                          child: Text('Add Buy',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Times New Roman',
                                                  fontSize: 30.0))),
                                      Padding(
                                        padding: EdgeInsets.only(right: 10.0),
                                        child: Icon(
                                          Icons.add_circle,
                                          color: Colors.white,
                                          size: MediaQuery.sizeOf(context)
                                                  .height *
                                              0.07,
                                        ),
                                      )
                                    ]),
                              ))),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: InkWell(
                          highlightColor: Colors.black.withOpacity(0.1),
                          //splashColor: Colors.transparent,
                          borderRadius: BorderRadius.circular(15.0),
                          onTap: () {
                            _.buys(context);
                          },
                          child: Padding(
                              padding: EdgeInsets.all(
                                  MediaQuery.sizeOf(context).height * 0.01),
                              child: Container(
                                height: MediaQuery.sizeOf(context).height * 0.2,
                                width: MediaQuery.sizeOf(context).width * 0.8,
                                decoration: BoxDecoration(
                                  //color: Color.fromARGB(255, 105, 105, 105),
                                  color: Colors.green,
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
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            left: 15.0, top: 50.0),
                                        child: Column(children: [
                                          Text('History',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Times New Roman',
                                                  fontSize: 20.0)),
                                          Text('and',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Times New Roman',
                                                  fontSize: 20.0)),
                                          Text('Statistics',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Times New Roman',
                                                  fontSize: 20.0))
                                        ]),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 10.0),
                                        child: Icon(
                                          Icons.auto_graph,
                                          color: Colors.white,
                                          size: MediaQuery.sizeOf(context)
                                                  .height *
                                              0.07,
                                        ),
                                      )
                                    ]),
                              ))),
                    )
                  ],
                ),
           
              )));
        });
  }
}
