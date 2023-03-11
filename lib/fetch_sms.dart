import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:permission_handler/permission_handler.dart';

class MessageRetriever {
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
      _messages = messages;
    } else {
      await Permission.sms.request();
    }
  }

  List<SmsMessage> getMessages() {
    return _messages;
  }
}
