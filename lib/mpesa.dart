import 'package:flutter/material.dart';
import 'backup/database.dart';

class MpesaListScreen extends StatelessWidget {
  const MpesaListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mpesa'),
        automaticallyImplyLeading: false,
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
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: message.recipient,
                          style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Color.fromARGB(255, 26, 27, 27),
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
                        TextSpan(
                          text: message.date,
                          style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Color.fromARGB(255, 27, 27, 27),
                          ),
                        ),
                      ],
                    ),
                  ),
                  trailing: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: message.isCredit ? '-KSH. ' : '+KSH. ',
                          style: TextStyle(
                            color: Color.fromARGB(255, 28, 29, 28),
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
                              fontWeight: FontWeight.normal,
                              color: Color.fromARGB(255, 28, 29, 28)),
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
