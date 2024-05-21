import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:sql_test_app/pages/auth/auth_page.dart';
import 'package:sql_test_app/pages/auth/signup/signup_controller.dart';
import 'package:get/get.dart';
import 'package:sql_test_app/widgets/my_elevated_button.dart';
//import 'package:pfr/widgets/pfr_logo_widget.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = (MediaQuery.of(context).size.width - 600) / 2;

    const cardBorderRadius = 30.0;

    return GetBuilder<SignUpController>(
      init: SignUpController(),
      initState: (_) {},
      builder: (_) {
        return Scaffold(
            body: Center(
          child: SingleChildScrollView(
              child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: (padding <= 0) ? 16 : padding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  //surfaceTintColor: Colors.grey,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(cardBorderRadius),
                  ),
                  color: Colors.grey.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: Form(
                      key: _.signUpKey,
                      child: Column(
                        children: [
                          /// Лого
                          //const PFRLogoWidget(),
                          FractionallySizedBox(
                              widthFactor: 0.5,
                              child: Image.asset(
                                'assets/logo.png',
                                width: 150.0,
                                height: 100.0,
                              )),

                          const SizedBox(height: 8),

                          const Divider(),

                          const SizedBox(height: 8),

                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _.emailController,
                            cursorColor: Colors.blueAccent,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                                labelText: 'E-mail',
                                prefixIcon: Icon(Icons.mail),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blueGrey,
                                  ),
                                )),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (email) =>
                                email != null && !EmailValidator.validate(email)
                                    ? 'Enter a valid email'
                                    : null,
                          ),

                          /// Логин
                          //MyTextFieldWithBorder(
                          //   controller: _.emailController,
                          //    hintText: 'E-mail',
                          //    prefixIcon: Icons.person,

                          //   ),

                          const SizedBox(height: 8),

                          /// Пароль
                          TextFormField(
                            controller: _.passController,
                            cursorColor: Colors.blueAccent,
                            textInputAction: TextInputAction.next,
                            obscureText: true,
                            decoration: const InputDecoration(
                                labelText: 'Пароль',
                                prefixIcon: Icon(Icons.lock),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blueGrey,
                                  ),
                                )),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) =>
                                value != null && value.length < 6
                                    ? 'Enter min 6 symbols.'
                                    : null,
                          ),
                          //MyTextFieldWithBorder(
                          //  controller: _.passController,
                          //  hintText: 'Пароль',
                          //  prefixIcon: Icons.lock,
                          //),

                          const SizedBox(height: 8),

                          /// Фамилия Имя
                          TextFormField(
                            controller: _.nameController,
                            cursorColor: Colors.blueAccent,
                            textInputAction: TextInputAction.next,
                            //obscureText: true,
                            decoration: const InputDecoration(
                                labelText: 'Фамилия Имя',
                                prefixIcon: Icon(Icons.person),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blueGrey,
                                  ),
                                )),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) =>
                                value != null && value.length < 6
                                    ? 'Enter min 6 symbols.'
                                    : null,
                          ),

                          const SizedBox(height: 8),

                          /// Должность
                          TextFormField(
                            controller: _.postController,
                            cursorColor: Colors.blueAccent,
                            textInputAction: TextInputAction.next,
                            //obscureText: true,
                            decoration: const InputDecoration(
                                labelText: 'Должность',
                                prefixIcon: Icon(Icons.stairs),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blueGrey,
                                  ),
                                )),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) =>
                                value != null && value.length < 5
                                    ? 'Enter min 5 symbols.'
                                    : null,
                          ),

                          const SizedBox(height: 8),

                          const SizedBox(height: 8),

                          /// Кнопка "Войти"
                          MyElevatedButton(
                            title: 'Регистрация',
                            onPressed: () {
                              _.signUp(context);
                            },
                            //backgroundColor: Colors.orange,
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Have account?'),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    // Navigator.pushReplacement(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             const AuthPage()));
                                  },
                                  child: const Text('Sign in!'))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
        ));
      },
    );
  }
}
