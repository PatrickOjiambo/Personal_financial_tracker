import 'package:flutter/material.dart';
import 'database.dart';

class MessageListScreen extends StatelessWidget {
  const MessageListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
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
                  title: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(text: 'Recipient: '),
                        TextSpan(
                          text: message.recipient,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                  subtitle: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(text: 'Amount: '),
                        TextSpan(
                          text: message.amount,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  trailing: Text(
                    message.isCredit ? 'Sent' : 'Received',
                    style: TextStyle(
                      color: message.isCredit ? Color.fromARGB(255, 235, 4, 24) : Color.fromARGB(255, 44, 196, 13),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
