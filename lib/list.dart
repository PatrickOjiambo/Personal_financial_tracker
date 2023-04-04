import 'package:flutter/material.dart';
import 'database.dart';

class MessageListScreen extends StatelessWidget {
  const MessageListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Messages'),
      ),
      body: FutureBuilder<List<Message>>(
        future: Future.value(Database.getAllMessages()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            final messages = snapshot.data!;
            return ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return ListTile(
                  title: Text(message.recipient),
                  subtitle: Text(message.amount),
                  trailing: Text(message.isCredit ? 'Credit' : 'Debit'),
                );
              },
            );
          }
          return const Center(
            child: Text('No messages found'),
          );
        },
      ),
    );
  }
}
