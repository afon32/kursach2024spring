import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:postgres/postgres.dart';
import 'package:sql_test_app/pages/add_buy/select_subcategory_page.dart';
import 'package:sql_test_app/pages/home_page/home_page.dart';
import 'package:sql_test_app/utils/utils.dart';
import 'package:sql_test_app/widgets/app_bar.dart';

class SelectCategoryPageController extends GetxController {
  String ownerID = 'a';
  bool isDownload = false;
  List categories = [];
  final addedCategory = TextEditingController();
  Future getCategories() async {
    print('\n  Im HERE! \n');
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
    final result2 = await conn.execute(
        "SELECT category_id, category_name FROM Category WHERE ((category_custom_owner_id = $ownerID OR category_custom_owner_id IS NULL) AND (category_parent_id is NULL)) ");
    categories = result2;
    print('\n  $categories  \n');
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
      return ListView.builder(
        addAutomaticKeepAlives: true,
        cacheExtent: 100.0,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          //return Text(ll[index][1].toString(), style: TextStyle(fontSize: 22),);
          return Padding(
              padding: const EdgeInsets.all(5.0),
              child: InkWell(
                highlightColor: Colors.black.withOpacity(0.1),
                //splashColor: Colors.transparent,
                borderRadius: BorderRadius.circular(15.0),
                child: Container(
                    height: Utils.categorySize,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.green),
                    child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(categories[index][1].toString(),
                                  style: const TextStyle(fontSize: 22)),

                              selectIcon(categories[index][1]),
                              // Icon(Icons.person_add_alt_1_rounded)
                            ]))),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SelectSubcategoryPage(),
                          settings:
                              RouteSettings(arguments: categories[index][0])));
                },
              ));
        },
        // )
      );
    }
  }

  Widget list(context) {
    // isDownload = false;
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 73, 76, 83),
        appBar: appBar(context),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(children: [
                  Container(
                      height: MediaQuery.of(context).size.height * 0.75,
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
                            child: Text(
                              'Выберите категорию',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Times New Roman',
                                  fontSize: 20.0),
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.64,
                          child: sss(isDownload),
                          // child: ListView.builder(
                          //   addAutomaticKeepAlives: true,
                          //   cacheExtent: 100.0,
                          //   itemCount: categories.length,
                          //   itemBuilder: (BuildContext context, int index) {
                          //     //return Text(ll[index][1].toString(), style: TextStyle(fontSize: 22),);
                          //     return Padding(
                          //         padding: const EdgeInsets.all(5.0),
                          //         child: InkWell(
                          //           child: Container(
                          //               height: Utils.categorySize,
                          //               decoration: BoxDecoration(
                          //                   borderRadius:
                          //                       BorderRadius.circular(5.0),
                          //                   color: Colors.green),
                          //               child: Padding(
                          //                   padding:
                          //                       const EdgeInsets.all(5.0),
                          //                   child: Row(
                          //                       mainAxisAlignment:
                          //                           MainAxisAlignment
                          //                               .spaceBetween,
                          //                       children: [
                          //                         Text(
                          //                             categories[index][1]
                          //                                 .toString(),
                          //                             style: const TextStyle(
                          //                                 fontSize: 22)),

                          //                         selectIcon(
                          //                             categories[index][1]),
                          //                         // Icon(Icons.person_add_alt_1_rounded)
                          //                       ]))),
                          //           onTap: () {
                          //             Navigator.push(
                          //                 context,
                          //                 MaterialPageRoute(
                          //                     builder: (context) =>
                          //                         const SelectSubcategoryPage(),
                          //                     settings: RouteSettings(
                          //                         arguments: categories[index]
                          //                             [0])));
                          //           },
                          //         ));
                          //   },
                          //   // )
                          // )
                        )
                      ])),
                  Padding(
                    padding: const EdgeInsets.only(top: 35.0),
                    child: InkWell(
                      child: Container(
                          height: Utils.categorySize,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              color: Colors.greenAccent),
                          child: const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(' Добавить категорию',
                                    style: const TextStyle(fontSize: 18)),
                                Icon(
                                  Icons.edit,
                                  size: Utils.categorySize * 0.7,
                                )
                              ],
                            ),
                          )),
                      onTap: () {
                        addCategory(context);
                      },
                    ),
                  )
                ]))));
  }

  Icon selectIcon(categoryName) {
    switch (categoryName) {
      case 'Автомобиль':
        {
          return const Icon(
            Icons.car_crash,
            size: Utils.categorySize * 0.7,
          );
        }
      case 'Супермаркет':
        {
          return const Icon(Icons.shopping_cart,
              size: Utils.categorySize * 0.7);
        }
      case 'Питомцы':
        {
          return const Icon(Icons.pets, size: Utils.categorySize * 0.7);
        }
      case 'Жильё':
        {
          return const Icon(Icons.house, size: Utils.categorySize * 0.7);
        }
      case 'Переводы':
        {
          return const Icon(Icons.attach_money, size: Utils.categorySize * 0.7);
        }
      case 'Рестораны':
        {
          return const Icon(Icons.restaurant, size: Utils.categorySize * 0.7);
        }
      default:
        return const Icon(Icons.build_circle, size: Utils.categorySize * 0.7);
    }
  }

  void addCategory(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color.fromARGB(255, 73, 76, 83),
            title: Center(
                child: Text('Добавление категории',
                    style: const TextStyle(fontSize: 15, color: Colors.white))),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    style: TextStyle(fontSize: 15, color: Colors.white),
                    controller: addedCategory,
                    cursorColor: Colors.white,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                        label: Text(
                          'Название',
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                        prefixIcon: Icon(
                          Icons.edit,
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
                                    MaterialStatePropertyAll<Color>(
                                        Colors.green),
                              ),
                              onPressed: () {
                                if (addedCategory.text.isEmpty) {
                                  Utils.showRedSnackBar('Заполните поле!');
                                } else {
                                  addCustomCategory();
                                  Navigator.pop(context);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              UserHomePage()));
                                }
                              },
                              child: const Text('Добавить')))),
                ],
              ),
            ),
          );
        });
  }

  Future addCustomCategory() async {
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
    await conn.execute(
        "INSERT INTO Category(category_name, category_custom_owner_id) VALUES('${addedCategory.text}', $ownerID)");

    conn.close();
  }
}
