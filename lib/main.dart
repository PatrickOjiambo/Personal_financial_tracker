import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:spend/screens/login_screen.dart';
import 'home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SpendSense',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        splashColor: Colors.white70,
      ),
      home: const SignInScreen(),
    );
  }
}
