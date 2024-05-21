
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sql_test_app/utils/utils.dart';
//import 'package:flutter_practice/pages/admin_pages/admin_order_page/admin_one_order_page_registration/admin_one_order_page_registration_page.dart';
import 'package:sql_test_app/pages/auth/signup/signup_page.dart';
import 'package:get/get.dart';



// class AuthController extends GetxController {
//   final emailController = TextEditingController();
//   final passController = TextEditingController();

//   Future signIn() async {
//     await FirebaseAuth.instance.signInWithEmailAndPassword(
//       email: '${emailController.text.trim()}@mail.ru',
//       password: passController.text.trim(),
//     );

//     final User? user = FirebaseAuth.instance.currentUser;

//     if (user == null) {
//       return;
//     } else {
//       SessionDataProvider().setSessionId(value: user.uid);
//       Get.toNamed(Routes.home);
//     }
//   }

//   readDataId() async {}

//   @override
//   void dispose() {
//     emailController.dispose();
//     passController.dispose();

//     super.dispose();
//   }
// }
class AuthController extends GetxController {
   final formKey = GlobalKey<FormState>();
   final emailController = TextEditingController();
   final passController = TextEditingController();

  get signUpVisible => null;

  Future signIn() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passController.text.trim(),
      );
    }
      on FirebaseAuthException catch (e) {
        print(e);
        Utils.showSnackBar(e.message);
    }
  }
  void onTapSignUp(BuildContext context){
    Navigator.push(context,
    MaterialPageRoute(builder: (context) => const SignUpPage()
    ));
  }


}
