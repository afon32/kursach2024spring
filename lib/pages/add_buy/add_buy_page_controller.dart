import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:postgres/postgres.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AddBuyPageController extends GetxController {
  final priceController = TextEditingController();
  String ownerID = 'a';
  List categories = [];
  int categoryID = 0;
  DateTime selectedDate = DateTime.now();

  void onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    print(args.value.toString());
    selectedDate = args.value;
  }

  Future getCategories(context) async {
    categoryID = ModalRoute.of(context)!.settings.arguments as int;
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
    await conn.execute("INSERT INTO Buy(buy_buyer_id, buy_price, buy_date, buy_category_id) VALUES ($ownerID,  ${int.parse(priceController.text)}, '$selectedDate', $categoryID)");
    conn.close();
  }

  void addBuy() {}
}
