import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:permission_handler/permission_handler.dart';
import 'backup/database.dart';
import 'package:intl/intl.dart';

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
        final isCredit = text.contains('sent') || text.contains('paid');
        ;

        final isDebit = text.contains('received') || text.contains('credited');
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
        final amountString = amountMatch?.group(1)?.trim() ?? '0.00';
        final amount = double.parse(amountString);
        print("***Amount: $amount");

        //Recipient
        final recipientRegex = RegExp(r'(to|from)\s+(\w+\s+\w+)');
        final recipientMatch = recipientRegex.firstMatch(text);
        final recipient = recipientMatch?.group(2) ?? '';
        print("***Recipient: $recipient");

        //date
        final dateRegex = RegExp(r'on ([\d/]+) at ([\d:]+)');
        final dateMatch = dateRegex.firstMatch(text);
        final date = dateMatch?.group(1) ?? '';

        print("***date: $date");

        final timeRegex =
            RegExp(r'(\d{1,2}:\d{2}\s*[AP]M)', caseSensitive: false);
        final timeMatch = timeRegex.firstMatch(text);
        final time2 = timeMatch?.group(1) ?? '';
        final time = time2.toUpperCase();
        print("***status: $status");
        print("***address: $address");
        print("****time: $time");

        final messageObject = Message(
            id: DateTime.now().millisecondsSinceEpoch,
            address: address,
            recipient: recipient,
            amount: amount,
            isCredit: isCredit,
            date: date,
            time: time);
        await Database.saveMessage(messageObject);
      }
    }
  }

  Map<String, List<SmsMessage>> getMessages() {
    return _messages;
  }
}
