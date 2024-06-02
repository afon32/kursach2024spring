import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:postgres/postgres.dart';
import 'package:sql_test_app/pages/add_buy/add_buy_page.dart';
import 'package:sql_test_app/pages/add_buy/select_category_page.dart';
import 'package:sql_test_app/utils/utils.dart';
import 'package:sql_test_app/widgets/app_bar.dart';

class SelectSubcategoryPageController extends GetxController {
  String ownerID = 'a';
  bool isDownload = false;
  List categories = [];
  int categoryID = 0;
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
        "SELECT category_id, category_name FROM Category WHERE category_parent_id = $categoryID");
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
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          //return Text(ll[index][1].toString(), style: TextStyle(fontSize: 22),);
          return Padding(
              padding: const EdgeInsets.all(5.0),
              child: InkWell(
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
                          builder: (context) => AddBuyPage(),
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
    categoryID = ModalRoute.of(context)!.settings.arguments as int;
    print('\n\n  $categoryID \n\n');
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
                              'Выберите подкатегорию',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Times New Roman',
                                  fontSize: 20.0),
                            ),
                          ),
                        ),
                        Container(
                            height: MediaQuery.of(context).size.height * 0.64,
                            child: sss(isDownload)
                            // ListView.builder(
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
                            //                         AddBuyPage(),
                            //                     settings: RouteSettings(
                            //                         arguments: categories[index]
                            //                             [0])));
                            //           },
                            //         ));
                            //   },
                            //   // )
                            // ))
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
                                Text(' Добавить подкатегорию',
                                    style: const TextStyle(fontSize: 18)),
                                Icon(
                                  Icons.edit,
                                  size: Utils.categorySize * 0.7,
                                )
                              ],
                            ),
                          )),
                      onTap: () {
                        addSubcategory(context);
                      },
                    ),
                  )
                ]))));
  }

  Icon selectIcon(categoryName) {
    switch (categoryName) {
      case 'Автозапчасти':
        {
          return const Icon(
            Icons.car_repair,
            size: Utils.categorySize * 0.7,
          );
        }
      case 'Ремонт':
        {
          return const Icon(Icons.construction,
              size: Utils.categorySize * 0.7);
        }
      case 'Страховка':
        {
          return const Icon(Icons.list_alt, size: Utils.categorySize * 0.7);
        }
      case 'Мойка':
        {
          return const Icon(Icons.local_car_wash, size: Utils.categorySize * 0.7);
        }
      case 'Продукты':
        {
          return const Icon(
            Icons.shopping_basket,
            size: Utils.categorySize * 0.7,
          );
        }
      case 'Стройматериалы':
        {
          return const Icon(Icons.construction,
              size: Utils.categorySize * 0.7);
        }
      case 'Электроника':
        {
          return const Icon(Icons.phonelink, size: Utils.categorySize * 0.7);
        }
      case 'Детский уход':
        {
          return const Icon(Icons.child_care, size: Utils.categorySize * 0.7);
        }
      case 'Аптека':
        {
          return const Icon(Icons.local_hospital, size: Utils.categorySize * 0.7);
        }
      case 'Корм':
        {
          return const Icon(Icons.food_bank, size: Utils.categorySize * 0.7);
        }
      case 'Средства ухода':
        {
          return const Icon(Icons.cleaning_services, size: Utils.categorySize * 0.7);
        }
      case 'ЖКХ':
        {
          return const Icon(Icons.maps_home_work, size: Utils.categorySize * 0.7);
        }
      case 'Ипотека':
        {
          return const Icon(Icons.sentiment_very_dissatisfied, size: Utils.categorySize * 0.7);
        }
      case 'Переводы людям':
        {
          return const Icon(Icons.person, size: Utils.categorySize * 0.7);
        }
      case 'Фаст-фуд':
        {
          return const Icon(Icons.fastfood, size: Utils.categorySize * 0.7);
        }
      case 'Кафе':
        {
          return const Icon(Icons.local_cafe, size: Utils.categorySize * 0.7);
        }
      case 'Ресторан':
        {
          return const Icon(Icons.restaurant_menu, size: Utils.categorySize * 0.7);
        }
      default:
        return const Icon(Icons.build_circle, size: Utils.categorySize * 0.7);
    }
  }

  void addSubcategory(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Добавление подкатегории'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: addedCategory,
                    cursorColor: Colors.blueAccent,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                        labelText: 'Название',
                        prefixIcon: Icon(Icons.mail),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueGrey,
                          ),
                        )),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.8,
                          child: ElevatedButton(
                              onPressed: () {
                                addCustomSubcategory();
                                Navigator.pop(context);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            SelectCategoryPage()));
                              },
                              child: const Text('Загрузка документов')))),
                ],
              ),
            ),
          );
        });
  }

  Future addCustomSubcategory() async {
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
        "INSERT INTO Category(category_name, category_custom_owner_id, category_parent_id) VALUES('${addedCategory.text}', $ownerID, $categoryID)");

    conn.close();
  }
}
