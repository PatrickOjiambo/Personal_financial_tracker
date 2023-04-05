import 'package:firebase_auth/firebase_auth.dart';
import 'fetch_sms.dart';
import 'package:flutter/material.dart';
import 'package:spend/screens/login_screen.dart';
import 'list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
   MessageRetriever _retriever = MessageRetriever();

  @override
  void initState() {
    super.initState();
    _initAsync();
  }

  Future<void> _initAsync() async {
    _retriever.queryMessages(['MPESA', 'Fay']).then((_) {
      return _retriever.analyzeMessages();
    }).then((_) {
      // Initialization is complete
    }).catchError((error) {
      // Handle initialization errors
    });
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(message),
            ElevatedButton(
              child: const Text("Log out"),
              onPressed: () {
                FirebaseAuth.instance.signOut().then(
                  (value) {
                    print("Signed out");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignInScreen()));
                  },
                );
              },
            ),
            //Calls the list for all the messages details saved into the database.
            ElevatedButton(
              child: const Text("List messages"),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MessageListScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
