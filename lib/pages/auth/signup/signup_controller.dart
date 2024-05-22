import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:postgres/legacy.dart';
import 'package:postgres/postgres.dart';
import 'package:sql_test_app/utils/utils.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final signUpKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final nameController = TextEditingController();
  final postController = TextEditingController();

  get signUpVisible => null;

  Future signUp(BuildContext context) async {
    final isValid = signUpKey.currentState!.validate();
    if (!isValid) return;
    try {
      final conn = await Connection.open(
          Endpoint(
              host: '94.198.220.56',
              port: 5430,
              database: 'afon32kursach',
              username: 'postgres',
              password: 'afanas228'),
          settings: const ConnectionSettings(sslMode: SslMode.disable));
      await conn.execute(
          "INSERT INTO AppUser(user_name, user_login, user_password) VALUES('${nameController.text}', '${emailController.text.trim()}', '${passController.text.trim()}')");
      conn.close();
    } on PostgreSQLException catch (e) {
      print(e);
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passController.text.trim(),
      );
      onTapSignIn(context);
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
    }
  }

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
    }
  }

  Future addToDB() async {
    final docUsers = FirebaseFirestore.instance.collection('users').doc();

    final jsonUser = {
      'username': nameController.text.trim(),
      'email': emailController.text.trim(),
      'password': passController.text.trim(),
      'post': postController.text.trim(),
      'level': 'none',
    };

    await docUsers.set(jsonUser);
  }

  void onTapSignIn(BuildContext context) {
    addToDB();
    Utils.showGreenSnackBar('Регистрация прошла успешно!');
    Navigator.pop(context);
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AuthPage()
    // ));
  }
}
