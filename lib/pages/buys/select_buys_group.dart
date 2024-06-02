import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sql_test_app/pages/buys/select_buys_group_controller.dart';

class SelectBuysGroup extends StatelessWidget {
  const SelectBuysGroup({super.key});

  Widget build(BuildContext context) {
    return GetBuilder(
      init: SelectBuysGroupController(),
      initState: (_) {},
      builder: (_) {
        _.isDownload = false;
        return FutureBuilder(
            future: _.getFamily(),
            builder: (context, snapshot) => Scaffold(body: _.grid(context)));
      },
    );
  }
}
