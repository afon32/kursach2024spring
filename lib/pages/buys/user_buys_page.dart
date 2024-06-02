import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sql_test_app/pages/buys/user_buys_page_controller.dart';
import 'package:sql_test_app/pages/home_page/home_page.dart';

class UserBuysPage extends StatelessWidget {
  const UserBuysPage({super.key});

  Widget build(BuildContext context) {
    return GetBuilder(
      init: UserBuysPageController(),
      initState: (_) {},
      builder: (_) {
        _.isDownload = false;
        return FutureBuilder(
            future: _.getBuys(),
            builder: (context, snapshot) => Scaffold(body: _.buyPage(context)));
      },
    );
  }
}
