import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:postgres/postgres.dart';
import 'package:sql_test_app/pages/add_buy/add_buy_page.dart';
import 'package:sql_test_app/pages/add_buy/select_category_page.dart';
import 'package:sql_test_app/utils/utils.dart';

class SelectSubcategoryPageController extends GetxController {
  String ownerID = 'a';
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
  }

  Widget list(context) {
    categoryID = ModalRoute.of(context)!.settings.arguments as int;
    print('\n\n  $categoryID \n\n');
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.black),
              ),
              // child: SingleChildScrollView(
              //   scrollDirection: Axis.vertical,
              child: ListView.builder(
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                  settings: RouteSettings(
                                      arguments: categories[index][0])));
                        },
                      ));
                },
                // )
              )),
          Padding(
            padding: const EdgeInsets.all(15.0),
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
                        Text('Добавить категорию'),
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
        ]));
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
          return const Icon(Icons.shopping_basket,
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
      default:
        return const Icon(Icons.person, size: Utils.categorySize * 0.7);
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
