import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sql_test_app/pages/add_buy/select_category_page.dart';
import 'package:sql_test_app/pages/invite/invite_page.dart';

class UserHomePageController extends GetxController {
  final userHomePageController = GlobalKey<FormState>();

  Future<void> documentsPage(BuildContext context) async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const InvitePage(),
        ));
 
  }

  void uploadDocumentsPage(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SelectCategoryPage(),
        ));
  }
}
