import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;



class MessageSender {
  final SmsQuery _query = SmsQuery();
  List<SmsMessage> _messages = [];

  Future<void> queryMessages() async {
    var permission = await Permission.sms.status;
    if (permission.isGranted) {
      final messages = await _query.querySms(
        kinds: [SmsQueryKind.inbox, SmsQueryKind.sent],
        address: 'MPESA',
        count: 20,
      );
      // debugPrint('messages ${messages}');
      debugPrint('sms inbox messages: ${messages.length}');
      _messages = messages;
    } else {
      await Permission.sms.request();
    }
  }

  List<Map<String, dynamic>> convertMessagesToJson() {
    List<Map<String, dynamic>> messagesJson = [];
    for (var message in _messages) {
      messagesJson.add({
        'sender': message.sender,
        'date': message.date.toString(),
        'body': message.body
      });
    }
    return messagesJson;
  }

  Future<void> sendMessagesToApi(String apiUrl) async {
    final messagesJson = convertMessagesToJson();
    final response = await http.post(
      Uri.parse(apiUrl)
    );

    if (response.statusCode != 200) {
      print('Failed to send messages to API');
    }

    if (response.statusCode == 200) {
      debugPrint("Received successfully");
    }
  }
}


Future<List<Map<String, String?>>> getMessages () async {
    SmsQuery query = SmsQuery();
    List<SmsMessage> messages = await query.querySms(
        kinds: [SmsQueryKind.inbox, SmsQueryKind.sent],
        address: 'MPESA',
        count: 20,
      );
    print("Messages :: $messages");
    List<Map<String, String?>> ms = [];

    for (var m in messages) {
      ms.add({
        'body': m.body,
        'sender': m.sender
      });
    }

    return ms;

}


Future<void> sendSomeStuff () async {
  var client = http.Client();
  var messages = await getMessages();
  print(messages);
  try {
    print(1);
    final response = await client.post(
      Uri.parse("https://localhost:8080/sms"),
      body: json.encode([]),
      headers: {
        "content-type": "application/json"
      }
    );
    print(2);

    if (response.statusCode == 200){
      debugPrint("Some stuff went good");
    } else {
      print(response.body);
      debugPrint("Some stuff went bad.");
    }
  } catch (e) {
    print(e);
  }

}