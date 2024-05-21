import 'package:flutter/material.dart';
import 'package:sql_test_app/widgets/load_indicator_widget.dart';

class CheckAuthPage extends StatelessWidget {
  const CheckAuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoadIndicatorWidget(),
      
    );
  }
}
