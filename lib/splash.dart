import 'package:flutter/material.dart';
import 'backup/database.dart';

class MessageListScreen extends StatelessWidget {
  final Function() onButtonClicked; // Callback function for button click

  const MessageListScreen({Key? key, required this.onButtonClicked}) : super(key: key);

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
              reverse: true,
              itemBuilder: (context, index) {
                final message = messages[index];
                return ListTile(
                  // List item UI
                );
              },
            );
          }
          return const Center(
            child: Text('No messages found'),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        // Example buttons, you can customize this as per your requirements
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Button 1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.email),
            label: 'Button 2',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: 'Button 3',
          ),
        ],
        onTap: (int index) {
          // Call the callback function when a button is clicked
          onButtonClicked();
        },
      ),
    );
  }
}
