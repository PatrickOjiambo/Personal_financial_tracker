import 'package:flutter/cupertino.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:permission_handler/permission_handler.dart';
import 'home_page.dart';

class FetchSms extends State<MyApp>
{
  final SmsQuery _query = SmsQuery();
  List<SmsMessage> _messages = [];

Future<void> fetchSms()
  async {
  var permission = await Permission.sms.status;
  if (permission.isGranted) {
  final messages = await _query.querySms(
  kinds: [SmsQueryKind.inbox, SmsQueryKind.sent],
  address: 'MPESA',
  count: 10,
  );
  debugPrint('sms inbox messages: ${messages.length}');

  setState(() => _messages = messages);
  } else {
  await Permission.sms.request();
  }
  }
}
