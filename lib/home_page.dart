import 'package:flutter/material.dart';
import 'fetch_sms.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final MessageRetriever _retriever = MessageRetriever();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SpendSense'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await _retriever.queryMessages();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Messages retrieved successfully')),
            );
          },
          child: const Text('Fetch SMS'),
        ),
      ),
    );
  }
}
