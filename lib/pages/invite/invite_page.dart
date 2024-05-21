import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sql_test_app/pages/invite/invite_page_controller.dart';

class InvitePage extends StatelessWidget {
  const InvitePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InvitePageController>(
      init: InvitePageController(),
      initState: (_) {},
      builder: (_) {
        return FutureBuilder(
            future: _.getDataAboutUser(),
            builder: (context, snapshot) => Scaffold(body: _.list()));
      },
    );
  }
}
