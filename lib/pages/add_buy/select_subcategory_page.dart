import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sql_test_app/pages/add_buy/select_subcategory_page_controller.dart';

class SelectSubcategoryPage extends StatelessWidget {
  const SelectSubcategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SelectSubcategoryPageController(),
      initState: (_) {},
      builder: (_) {
        return FutureBuilder(
            future: _.getCategories(),
            builder: (context, snapshot) => Scaffold(body: _.list(context)));
      },
    );
  }
}
