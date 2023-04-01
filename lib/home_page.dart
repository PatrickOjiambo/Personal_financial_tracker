import 'package:firebase_auth/firebase_auth.dart';
import 'fetch_sms.dart';
import 'package:flutter/material.dart';
import 'package:spend/screens/login_screen.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}


class HomePageState extends State<HomePage> {
  late final MessageRetriever _retriever;

  @override
  void initState() {
    super.initState();
    _retriever = MessageRetriever();
    _retriever.queryMessages(['MPESA', 'Fay']);
    _retriever.analyzeMessages();
  }

  @override
  Widget build(BuildContext context) {
    String message = "";
    if (_retriever.getMessages().isNotEmpty) {
      message = "Messages retrieved successfully!";
    } else {
      message = "Messages not retrieved";
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message),
            ElevatedButton(
              child: const Text("Log out"),
              onPressed: (){
                FirebaseAuth.instance.signOut().then((value){
                  print("Signed out");
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignInScreen()));
                });
              },
            ),

          ],
        ),
      ),
    );
  }
}
