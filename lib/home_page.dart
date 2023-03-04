import 'package:flutter/material.dart';
import 'fetch_sms.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final MessageSender _sender = MessageSender();
  final String _apiUrl = 'http://127.0.0.1:8000/docs#/default/receive_sms_sms_post';

  @override
  void initState() {
    super.initState();
    _sender.queryMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My App'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await _sender.sendMessagesToApi(_apiUrl);
          },
          child: const Text('Send SMS to API'),
        ),
      ),
    );
  }
}
