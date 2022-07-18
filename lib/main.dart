import 'package:flutter/material.dart';
import 'package:splash/Modals/authenticate.dart';
import 'package:splash/Screens/chatroom.dart';
import 'package:splash/Screens/signin.dart';
import 'package:splash/Screens/signup.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.redAccent,
          scaffoldBackgroundColor: Color(0xff1F1F1F),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.redAccent,
            elevation: 10,
          )),
      home: authenticate(),
    );
  }
}
