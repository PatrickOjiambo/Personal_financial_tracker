import 'fetch_sms.dart';
import 'package:flutter/material.dart';
import 'package:spend/screens/login_screen.dart';
import 'list_sms.dart';

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
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignInScreen()));
              },
            ),
            ElevatedButton(
              child: const Text("View Messages"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  const MessageListScreen(address: '',)));
              },
            ),
          ],
        ),
      ),
    );
  }
}
