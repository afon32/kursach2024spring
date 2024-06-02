import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

bool isDownload = false;
String ownerID = 'a';
String ownerName = 'a';
List res = [];
List buy = [];
String buyCategory = '';
String buyer = '';
String buyPrice = '';
String buyDate = '';

Future getInfoAboutBuy(buyID) async {
  final conn = await Connection.open(
      Endpoint(
          host: '94.198.220.56',
          port: 5430,
          database: 'afon32kursach',
          username: 'postgres',
          password: 'afanas228'),
      settings: const ConnectionSettings(sslMode: SslMode.disable));
  
  final result = await conn.execute(
      "SELECT buy_buyer_id, buy_date, buy_price, buy_category_id FROM Buy WHERE (buy_id = $buyID)");
  print ('after 1');
  final result2 = await conn.execute(
      "SELECT category_name FROM Category WHERE (category_id = ${result[0][3]})");
  print ('after 2');
  final result3 = await conn.execute(
      "SELECT user_name FROM AppUser WHERE (user_id = ${result[0][0]})");
  print ('after 3');
  buyCategory = result2[0][0].toString();
  print(buyCategory);
  buyer = result3[0][0].toString();
  print(buyer);
  buyPrice = result[0][2].toString();
  print(buyPrice);
  buyDate = result[0][1].toString().substring(5, 16);
  print('$buyer $buyCategory $buyPrice $buyDate');
  conn.close();
  isDownload = true;
}

Widget sss(prop, context) {
  if (!prop) {
    return const Center(
        child: CircularProgressIndicator(
      color: Colors.green,
    ));
  } else {
    return AlertDialog(
       backgroundColor: Color.fromARGB(255, 73, 76, 83),
                  title: const Text('Покупка:', style: TextStyle(color: Colors.green)),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Покупатель:', style: TextStyle(color: Colors.white)),
                                Text(buyer, style: TextStyle(color: Colors.white))
                              ],
                            )),
                        //Text('ID: ${userID}')),
                        Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Категория:', style: TextStyle(color: Colors.white)),
                                Text(buyCategory, style: TextStyle(color: Colors.white))
                              ],
                            )),
                        Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [const Text('Сумма:', style: TextStyle(color: Colors.white)), Text(buyPrice, style: TextStyle(color: Colors.white))],
                            )),
                        Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [const Text('Дата:', style: TextStyle(color: Colors.white)), Text(buyDate, style: TextStyle(color: Colors.white))],
                            )),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Закрыть', style: TextStyle(color: Colors.green)),
                    ),
                  ],
                );
  }
}


void showBuyInfo(BuildContext context, buyID) {
  isDownload = false;
  showDialog(
      context: context,
      builder: (context) {
        return FutureBuilder(
            future: getInfoAboutBuy(buyID),
            builder: (context, snapshot) => sss(isDownload, context));
      });
}
