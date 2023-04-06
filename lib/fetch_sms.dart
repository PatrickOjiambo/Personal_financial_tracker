import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:permission_handler/permission_handler.dart';
import 'database.dart';

class MessageRetriever {
  final SmsQuery _query = SmsQuery();
  final Map<String, List<SmsMessage>> _messages = {};

  Future<void> queryMessages(List<String> addresses) async {
    print("%%%%%%%Query function called successfully");
    var permission = await Permission.sms.status;
    if (permission.isGranted) {
      for (String address in addresses) {
        final messages = await _query.querySms(
          kinds: [SmsQueryKind.inbox],
          address: address,
          count: 20,
        );
        _messages[address] = messages;
        print("%%%%%%%%%%%%Messages retrieved for $address:");
        for (var message in messages) {
          print("${message.address}: ${message.body}");
        }
      }
    } else {
      await Permission.sms.request();
    }
  }

  Future<void> analyzeMessages() async {
    print("######Analyzer function called successfully");

    for (final entry in _messages.entries) {
      final address = entry.key;
      final messages = entry.value;

      for (final message in messages) {
        final text = message.body!.toLowerCase();

        // Determine whether it's a credit or debit message
        final isCredit = text.contains('received');
        final isDebit = text.contains('sent');
        String status;
        if (isCredit == true) {
          status = "Credit";
        } else if (isDebit == true) {
          status = "Debit";
        } else {
          continue;
        }

        // Extract amount, recipient, and date
        final amountRegex = RegExp(r'ksh([\d,]+(\.\d{1,2})?)');
        final amountMatch = amountRegex.firstMatch(text);
        final amount = amountMatch?.group(1) ?? '0.00';
        print("***Amount: $amount");

        final recipientRegex =
            isCredit ? RegExp(r'from (.+?) on') : RegExp(r'to (.+?) for');
        final recipientMatch = recipientRegex.firstMatch(text);
        final recipient = recipientMatch?.group(1) ?? '';
        print("***recipient: $recipient");

        final dateRegex = RegExp(r'on ([\d/]+) at ([\d:]+)');
        final dateMatch = dateRegex.firstMatch(text);
        final date = dateMatch?.group(1) ?? '';
        print("***date: $date");

        final timeMatch = dateRegex.firstMatch(text);
        final time = timeMatch?.group(2) ?? '';
        print("***time: $time");
        print("***status: $status");
        print("***address: $address");

        final messageObject = Message(
          id: DateTime.now().millisecondsSinceEpoch,
          address: address,
          recipient: recipient,
          amount: amount,
          isCredit: isCredit,
          date: date,
        );
        await Database.saveMessage(messageObject);
      }
    }
  }

  Map<String, List<SmsMessage>> getMessages() {
    return _messages;
  }
}
