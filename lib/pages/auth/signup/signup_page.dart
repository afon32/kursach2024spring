import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
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
            backgroundColor: const Color.fromARGB(255, 12, 62, 14),
            body: Center(
              child: SingleChildScrollView(
                  child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: (padding <= 0) ? 16 : padding),
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
                      color: Color.fromARGB(255, 73, 76, 83),
                      child: Padding(
                        padding: const EdgeInsets.all(40),
                        child: Form(
                          key: _.signUpKey,
                          child: Column(
                            children: [
                              /// Лого
                              //const PFRLogoWidget(),
                              FractionallySizedBox(
                                  widthFactor: 1.0,
                                  child: Image.asset(
                                    'assets/azlogo.jpg',
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                  )),

                              const SizedBox(height: 8),

                              const Divider(),

                              const SizedBox(height: 8),

                              const SizedBox(height: 8),
                              TextFormField(
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                                controller: _.emailController,
                                cursorColor: Colors.white,
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                  label: Text(
                                    'E-mail',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.grey),
                                  ),
                                   prefixIcon: Icon(
                                    Icons.email,
                                    color: Colors.white,
                                  ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      ),
                                    )),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (email) => email != null &&
                                        !EmailValidator.validate(email)
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
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                              controller: _.passController,
                              cursorColor: Colors.white,
                              textInputAction: TextInputAction.next,
                              obscureText: true,
                              decoration: const InputDecoration(
                                  label: Text(
                                    'Пароль',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.grey),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.white,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
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
                                style: TextStyle(fontSize: 15, color: Colors.white),
                                controller: _.nameController,
                                cursorColor: Colors.white,
                              textInputAction: TextInputAction.next,
                              
                              decoration: const InputDecoration(
                                  label: Text(
                                    'Имя',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.grey),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
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

                           

                              const SizedBox(height: 8),

                              const SizedBox(height: 8),

                              /// Кнопка "Войти"
                              MyElevatedButton(
                                backgroundColor: Colors.green,
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
