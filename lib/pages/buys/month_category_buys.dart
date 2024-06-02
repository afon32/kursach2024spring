import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';
import 'package:sql_test_app/data/appres.dart';
import 'package:sql_test_app/pages/home_page/home_page.dart';
import 'package:sql_test_app/utils/utils.dart';
import 'package:sql_test_app/widgets/app_bar.dart';
import 'package:sql_test_app/widgets/buy_info.dart';
import 'package:sql_test_app/widgets/indicator.dart';

class MonthCategoryBuys extends StatefulWidget {
  const MonthCategoryBuys({super.key});

  @override
  State<StatefulWidget> createState() => MonthCategoryBuysState();
}

class MonthCategoryBuysState extends State {
  int touchedIndex = -1;
  bool getInfoEnd = false;
  var args;
  bool isGroup = false;
  String categoryName = '';
  String month = '';
  String userID = '';
  List monthBuys = [];
  List subcategoriesBuys = [];
  List monthBuysCategoriesList = [];
  List categoryBuysTotal = [];
  List<Map<String, dynamic>> data = [
    {'label': 'Section 1', 'value': 40},
    {'label': 'Section 2', 'value': 30},
    {'label': 'Section 3', 'value': 20},
    {'label': 'Section 4', 'value': 10},
  ];
  // Map<int, String> monthBuysCategoriesList = {};
  @override
  Widget build(BuildContext context) {
    if (!getInfoEnd) {
      getInfo(context);
      return Center(
          child: CircularProgressIndicator(
        color: Colors.green,
      ));
    } else {
      // return FutureBuilder(
      //     future: getInfo(context),
      //     builder: (context, snapshot) {

      return Scaffold(
        backgroundColor: Color.fromARGB(255, 73, 76, 83),
        appBar: appBar(context),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.87,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Column(children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.03,
                        child: Center(
                          child: Text('Статистика по категории',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Times New Roman',
                                  fontSize: 20.0)),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.4,
                            decoration: BoxDecoration(),
                            child: PieChart(
                              PieChartData(
                                sections: showingSections(),
                                pieTouchData: PieTouchData(
                                  touchCallback:
                                      (FlTouchEvent event, pieTouchResponse) {
                                    setState(() {
                                      if (!event.isInterestedForInteractions ||
                                          pieTouchResponse == null ||
                                          pieTouchResponse.touchedSection ==
                                              null) {
                                        touchedIndex = -1;
                                        return;
                                      }
                                      touchedIndex = pieTouchResponse
                                          .touchedSection!.touchedSectionIndex;
                                      print('Touched index: $touchedIndex');
                                      print(
                                          'Touched label: ${data[touchedIndex]['label']}');
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //       builder: (context) => const UserHomePage(),
                                      //       settings: RouteSettings(
                                      //           arguments: data[touchedIndex]['label'])),
                                      // );
                                      // Здесь вы можете обрабатывать клик по определённому участку диаграммы
                                    });
                                  },
                                ),
                              ),
                            ),
                          )),
                           Container(
                        height: MediaQuery.of(context).size.height * 0.03,
                        child: Center(
                          child: Text('Расходы',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Times New Roman',
                                  fontSize: 20.0)),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Container(
                              height: MediaQuery.of(context).size.height * 0.38,
                              child: Scrollbar(
                                child: ListView.builder(
                                    itemCount: subcategoriesBuys.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: InkWell(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                color: Colors.green),
                                            height: Utils.categorySize,
                                            child: Padding(
                                              padding: EdgeInsets.all(5.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(subcategoriesBuys[index]
                                                          [2]
                                                      .toString()),
                                                  Text(subcategoriesBuys[index]
                                                          [1]
                                                      .toString()
                                                      .substring(5, 16))
                                                ],
                                              ),
                                            ),
                                          ),
                                          onTap: () {
                                            showBuyInfo(
                                                context, monthBuys[index][0]);
                                          },
                                        ),
                                      );
                                    }),
                              ))),
                    ])))),
      );
      //}
    }
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(data.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      return PieChartSectionData(
        badgeWidget: selectIcon(data[i]['label']),
        color: Colors.primaries[i % Colors.primaries.length],
        value: data[i]['value'].toDouble(),
        title: '',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff),
        ),
      );
    });
  }

  Future getInfo(BuildContext context) async {
    args = ModalRoute.of(context)!.settings.arguments;
    month = args[0].toString();
    userID = args[1].toString();
    categoryName = args[2].toString();
    isGroup = args[3];
    monthBuys = [];
    monthBuysCategoriesList = [];
    List categoryTotal = [];
    String familyMembersList = '';
    subcategoriesBuys = [];
    final conn = await Connection.open(
        Endpoint(
            host: '94.198.220.56',
            port: 5430,
            database: 'afon32kursach',
            username: 'postgres',
            password: 'afanas228'),
        settings: const ConnectionSettings(sslMode: SslMode.disable));
    print('after conn');
    Result result;
    if (isGroup) {
      final resul = await conn.execute(
          "SELECT family_member_id FROM Family WHERE (family_owner_id = $userID)");
      print(resul);
      familyMembersList = '$userID';
      if (resul.length > 0) {
        for (List member in resul) {
          familyMembersList = '$familyMembersList, ${member[0]}';
        }
      }
      print(familyMembersList);
      result = await conn.execute(
          "SELECT buy_id, buy_date, buy_price, buy_category_id FROM Buy WHERE (buy_buyer_id IN ($familyMembersList))");
    } else {
      result = await conn.execute(
          "SELECT buy_id, buy_date, buy_price, buy_category_id FROM Buy WHERE (buy_buyer_id = $userID)");
    }
    print(result);

    for (List buy in result) {
      final res = await conn
          .execute("SELECT date_part('month', timestamp '${buy[1]}')");
      print(res);
      print(month);
      if (res[0][0] == int.parse(month)) {
        monthBuys.add(buy);
      }
    }
    print(monthBuys);

    for (int i = 0; i < monthBuys.length; i++) {
      final result = await conn.execute(
          "SELECT category_parent_id, category_name FROM Category WHERE (category_id = ${monthBuys[i][3]})");
      final result2 = await conn.execute(
          "SELECT category_id, category_name FROM Category WHERE (category_id = ${result[0][0]})");
      // Map<int,String> temp = {monthBuys[i][0] : result2[0][1].toString()};
      // monthBuysCategoriesList.addEntries(temp.entries);
      // monthBuys[i].add(result2[0][1]);
      // monthBuys[i] = 0;
      monthBuysCategoriesList
          .add([result2[0][1], monthBuys[i][2], result[0][1]]);
    }
    print(monthBuys);
    print(monthBuysCategoriesList);

    final result4 = await conn.execute(
        "SELECT category_id FROM Category WHERE (category_name = '$categoryName')");
    for (buy in monthBuys) {
      final tempResult = await conn.execute(
          "SELECT category_parent_id FROM Category WHERE (category_id = ${buy[3]})");
      if (tempResult[0][0] == result4[0][0]) {
        subcategoriesBuys.add(buy);
      }
    }
    Result result3;
    if (isGroup) {
      // final resul = await conn.execute(
      //     "SELECT family_member_id FROM Family WHERE (family_owner_id = $userID)");
      // print(resul);
      // familyMembersList = '$userID';
      // if (resul.length > 0) {
      //   for (List member in resul) {
      //     familyMembersList = '$familyMembersList, ${member[0]}';
      //   }
      // }
      // print(familyMembersList);

      result3 = await conn.execute(
          "SELECT category_name FROM Category WHERE (category_parent_id = ${result4[0][0]} AND (category_custom_owner_id IN ($familyMembersList) OR category_custom_owner_id is NULL))");
    } else {
      result3 = await conn.execute(
          "SELECT category_name FROM Category WHERE (category_parent_id = ${result4[0][0]} AND (category_custom_owner_id = $userID OR category_custom_owner_id is NULL))");
    }
    for (buy in monthBuysCategoriesList) {
      if (buy[2] == result4[0][0]) {}
    }
    print(subcategoriesBuys);

    for (List list in result3) {
      categoryTotal.add([list[0], 0.0]);
    }
    print(categoryTotal);
    for (List catBuy in monthBuysCategoriesList) {
      for (int i = 0; i < categoryTotal.length; i++) {
        if (catBuy[2] == categoryTotal[i][0]) {
          categoryTotal[i][1] += catBuy[1];
        }
      }
    }
    conn.close();
    categoryBuysTotal = categoryTotal;
    print(categoryBuysTotal);

    List<Map<String, dynamic>> data1 = [];
    for (List list in categoryBuysTotal) {
      if (list[1] != 0) {
        Map<String, dynamic> temp = {'label': list[0], 'value': list[1]};
        data1.add(temp);
      }
    }
    data = data1;
    getInfoEnd = true;
    print(data);
    setState(() {});
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
}
