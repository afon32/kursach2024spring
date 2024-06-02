import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sql_test_app/pages/auth/auth_page.dart';
import 'package:sql_test_app/pages/home_page/home_page.dart';
import 'package:sql_test_app/utils/firebase_helper.dart';
import 'package:sql_test_app/utils/utils.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

// Future<void> main(List<String> arguments) async {
//   //final con = PostgreSQLConnection('94.198.220.56', 5430, 'afon32kursach', );
//   final conn = await Connection.open(Endpoint(host: '94.198.220.56',port: 5430, database: 'afon32kursach', username: 'postgres', password: 'afanas228')); 
//   final result = await conn.execute("SELECT * FROM Products");
//   print(result);
  
// }


Future<void> main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await FirebaseHelper.connect();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return GetMaterialApp(
      scaffoldMessengerKey: Utils.messengerKey,
      debugShowCheckedModeBanner: false,
      title: 'ХКД',
      theme: FlexThemeData.light(
        scheme: FlexScheme.blue,
        scaffoldBackground: Colors.grey.shade100,
      ),
      home: const MainPage(),
    );
  }
}


class MainPage extends StatelessWidget{
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) =>Scaffold(
    
    body: StreamBuilder<User?>(
      builder: (context, snapshot){
        if (snapshot.hasData){
          User? user = snapshot.data;
          if (user != null) {
            return const UserHomePage();
          }
          else {
            return const UserHomePage();
          }
        }
        else{
          return const AuthPage();
        }
      }, 
      stream: FirebaseAuth.instance.authStateChanges(),
      )
  );
}