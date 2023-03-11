import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
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
      home: const HomePage(),
    );
  }
}
