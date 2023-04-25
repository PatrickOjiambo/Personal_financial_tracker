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
  static List<Message> getEquity(){
  return _messageBox.values
  .where((Message) => Message.address == "Equity bank").toList();
  }
  static List<Message> getMpesa(){
  return _messageBox.values
  .where((Message) => Message.address == "Mpesa").toList();

  }
  static List<Message> getStanchart(){
  return _messageBox.values
  .where((Message) => Message.address == "StanChart").toList();
  }
  static List<Message> getAbsa(){
  return _messageBox.values
  .where((Message) => Message.address == "Absa Bank").toList();
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
  double amount;

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
