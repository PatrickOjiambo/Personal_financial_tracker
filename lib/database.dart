import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

class Database {
  static late Box<Message> _messageBox;

  static Future<void> initialize() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    Hive.registerAdapter(MessageAdapter());

    _messageBox = await Hive.openBox<Message>('messages');
    print('%%%%%%Message box opened: ${_messageBox.name}');
    print("%%%%%pati%%%%Database directory: ${appDocumentDir.path}");
  }

  static Future<void> openBox(String name) async {
    _messageBox = await Hive.openBox<Message>(name);
  }

  static Future<void> saveMessage(Message message) async {
    await _messageBox.add(message);
  }

  static List<Message> getAllMessages() {
    return _messageBox.values.toList();
  }

  static Future<double> fetch_amount() async {
    // Query the messagesBox to retrieve the data you want
    final queryResult = _messageBox.values.where(
      (message) => message.address == 'mpesa' && (message.isCredit == false),
    );

    // Calculate the total amount for debits
    final debitTotalAmount = queryResult.fold<double>(
      0.0,
      (double sum, message) => sum + double.parse(message.amount),
    );

    // Query the messagesBox again to retrieve the data you want
    final queryResult2 = _messageBox.values.where(
      (message) => message.address == 'mpesa' && (message.isCredit == true),
    );

    // Calculate the total amount for credits
    final creditTotalAmount = queryResult2.fold<double>(
      0.0,
      (double sum, message) => sum + double.parse(message.amount),
    );
    double total = creditTotalAmount + debitTotalAmount;
    print("All the totals: $total");

    // Return the total amount for debits and credits
    return total;
  }
}

@HiveType(typeId: 0)
class Message extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String address;

  @HiveField(2)
  String recipient;

  @HiveField(3)
  String amount;

  @HiveField(4)
  bool isCredit;

  @HiveField(5)
  String date;

  Message({
    required this.address,
    required this.recipient,
    required this.amount,
    required this.isCredit,
    required this.date,
    required int id,
  }) : id = DateTime.now().millisecondsSinceEpoch;
}
