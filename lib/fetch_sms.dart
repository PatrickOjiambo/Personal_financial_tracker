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
        count: 10,
      );
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
      Uri.parse(apiUrl),
      body: messagesJson,
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to send messages to API');
    }
  }
}
