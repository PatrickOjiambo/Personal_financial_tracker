import 'package:flutter/material.dart';
import 'backup/database.dart';


class MessageListScreen extends StatelessWidget {
  const MessageListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
        leading: null,
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
              reverse: false,
              itemBuilder: (context, index) {
                final message = messages[index];
                return ListTile(
                  title: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Color.fromARGB(255, 26, 25, 25),
                      ),
                      children: [
                        TextSpan(
                          text: message.recipient,
                          style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Color.fromARGB(255, 23, 24, 24),
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                  subtitle: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Color.fromARGB(255, 24, 22, 22),
                      ),
                      children: [
                      TextSpan(
                          text: message.date,
                          style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Color.fromARGB(255, 28, 29, 29),
                          ),
                        ),
                      ],
                    ),
                  ),
                  trailing: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Color.fromARGB(255, 31, 30, 30),
                      ),
                      children: [
                        TextSpan(
                          text: message.isCredit ? '-KSH. ' : '+KSH. ',
                          style: TextStyle(
                            color: Color.fromARGB(255, 34, 33, 33),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        TextSpan(
                          text: message.amount.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Color.fromARGB(255, 37, 37, 37),
                          ),
                        ),
                         TextSpan(
                          text: '\n\t\t\t\t\t\t\t\t\t' + message.time,
                          style: const TextStyle(
                              fontWeight: FontWeight.normal, color: Color.fromARGB(255, 32, 32, 32)),
                        ),
                        
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: Text('No transactions found'),
          );
        },
      ),
    );
  }
}
