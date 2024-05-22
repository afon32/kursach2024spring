import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sql_test_app/pages/add_buy/select_category_page_controller.dart';

class SelectCategoryPage extends StatelessWidget {
  const SelectCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SelectCategoryPageController(),
      initState: (_) {},
      builder: (_) {
        return FutureBuilder(
            future: _.getCategories(),
            builder: (context, snapshot) => Scaffold(body: _.list(context)));
      },
    );
  }
}
