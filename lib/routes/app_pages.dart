import 'package:get/get.dart';
import 'package:sql_test_app/pages/auth/auth_controller.dart';
import 'package:sql_test_app/pages/auth/auth_page.dart';
import 'package:sql_test_app/pages/auth/check_auth/check_auth_controller.dart';
import 'package:sql_test_app/pages/auth/check_auth/check_auth_page.dart';
// import 'package:fp/pages/dashboard/dashboard_controller.dart';
// import 'package:fp/pages/dashboard/dashboard_page.dart';
// import 'package:fp/pages/extension/extension_controller.dart';
// import 'package:fp/pages/extension/extension_page.dart';
// import 'package:fp/pages/purpose/purpose_controller.dart';
// import 'package:fp/pages/purpose/purpose_page.dart';
//import 'package:fp/pages/termination/termination_controller.dart';
//import 'package:fp/pages/termination/termination_page.dart';
import 'package:sql_test_app/routes/app_routes.dart';

class AppPages {
  AppPages._();

  /// Домашний экран
  static const initialRoute = Routes.checkAuth;

  static final routes = [
    GetPage(
      name: Routes.checkAuth,
      page: () => const CheckAuthPage(),
      binding: BindingsBuilder(() {
        Get.put(CheckAuthController());
      }),
    ),
    GetPage(
      name: Routes.auth,
      page: () => const AuthPage(),
      binding: BindingsBuilder(() {
        Get.put(AuthController());
      }), 
    ),
  
  ];
}
