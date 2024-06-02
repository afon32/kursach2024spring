import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sql_test_app/pages/add_buy/select_category_page.dart';
import 'package:sql_test_app/pages/buys/sample.dart';
import 'package:sql_test_app/pages/buys/select_buys_group.dart';
import 'package:sql_test_app/pages/buys/user_buys_page.dart';
import 'package:sql_test_app/pages/invite/invite_page.dart';

class UserHomePageController extends GetxController {
  final userHomePageController = GlobalKey<FormState>();

  Future<void> groupPage(BuildContext context) async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const InvitePage(),
        ));
 
  }
  Future<void> invitePage(BuildContext context) async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const InvitePage(),
        ));
 
  }

  void addBuy(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SelectCategoryPage(),
        ));
  }
  void buys(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SelectBuysGroup(),
        ));
  }
  void sample(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>  UserBuysPage(),
        ));
  }
}
