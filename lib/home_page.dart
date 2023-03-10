import 'package:flutter/material.dart';
import 'fetch_sms.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final MessageSender _sender = MessageSender();
  final String _apiUrl = 'http://127.0.0.1:8000/sms';

  @override
  void initState() {
    super.initState();
    _sender.queryMessages();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send SMS'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // await _sender.sendMessagesToApi(_apiUrl);
            await sendSomeStuff();
            // await getMessages();
          },
          child: const Text('Send SMS to API'),
        ),
      ),
    );
  }
}
