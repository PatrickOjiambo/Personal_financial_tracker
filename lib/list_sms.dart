import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'database.dart';

class MessageListScreen extends StatefulWidget {
  final String address;

  const MessageListScreen({super.key, required this.address});

  @override
  _MessageListScreenState createState() => _MessageListScreenState();
}

class _MessageListScreenState extends State<MessageListScreen> {
  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    final Database db = await SQLDatabase.db();
    final List<Map<String, dynamic>> result = await db.query(
      'messages',
      where: 'address = ?',
      whereArgs: [widget.address],
    );
    setState(() {
      messages = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.address),
      ),
      body: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (BuildContext context, int index) {
          final message = messages[index];
          final recipient = message['recipient'];
          final date = message['date'];
          final amount = message['amount'];
          return ListTile(
            title: Text(recipient),
            subtitle: Text(date),
            trailing: Text(amount),
          );
        },
      ),
    );
  }
}
