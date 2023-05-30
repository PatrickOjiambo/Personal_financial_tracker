import 'dart:convert';
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

class Database {
  static late Box<Message> _messageBox;
    static late Box<Target> _targetBox;

  static Future<void> initialize() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    Hive.registerAdapter(MessageAdapter());
    Hive.registerAdapter(TargetAdapter());

    _messageBox = await Hive.openBox<Message>('messages');
        _targetBox = await Hive.openBox<Target>('target');
    print('%%%%%%Message box opened: ${_messageBox.name}');
        print('%%%%%%Target box opened: ${_targetBox.name}');
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
  .where((Message) => Message.address == "MPESA").toList();

  }
  static List<Message> getStanchart(){
  return _messageBox.values
  .where((Message) => Message.address == "StanChart").toList();
  }
  static List<Message> getAbsa(){
  return _messageBox.values
  .where((Message) => Message.address == "Absa Bank").toList();
  }
  //Returns the amount transacted by the diff banks
  static double getAbsaAmount(){
    return _messageBox.values
      .where((Message) =>Message.address == "Absa bank")
      .map((message) => message.amount)
      .fold(0, (prev, curr) => prev + curr);
  }
 static double getMpesaAmount(){
    return _messageBox.values
      .where((Message) =>Message.address == "MPESA")
      .map((message) => message.amount)
      .fold(0, (prev, curr) => prev + curr);
  }
   static double getStanchartAmount(){
    return _messageBox.values
      .where((Message) =>Message.address == "Stanchart")
      .map((message) => message.amount)
      .fold(0, (prev, curr) => prev + curr);
  }

   static double getEquityAmount(){
    return _messageBox.values
      .where((Message) =>Message.address == "Equity bank")
      .map((message) => message.amount)
      .fold(0, (prev, curr) => prev + curr);
  }


  static double getTotalAmount() {
  return _messageBox.values
      .where((Message) =>Message.isCredit == true)
      .map((message) => message.amount)
      .fold(0, (prev, curr) => prev + curr);
}
static double getTotalCreditAmount() {
  return _messageBox.values
      .where((message) => message.isCredit == true)
      .map((message) => message.amount)
      .fold(0, (prev, curr) => prev + curr);
}
static double getTotalDebitAmount() {
  return _messageBox.values
      .where((message) => message.isCredit == false)
      .map((message) => message.amount)
      .fold(0, (prev, curr) => prev + curr);
}

 static void saveTargetAmount(double amount) {
    final target = Target(target: amount);
    _targetBox.put('target', target);
  }

  static double getTargetAmount() {
    final target = _targetBox.get('target');
    return target?.target ?? 0;
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

  @HiveField(6)
  String time;

  Message({
    required this.address,
    required this.recipient,
    required this.amount,
    required this.isCredit,
    required this.date,
    required int id,
    required this.time
  }) : id = DateTime.now().millisecondsSinceEpoch;


  Map <String, dynamic> toJson() =>{

    'address': this.address,
    'recipient': this.recipient,
    'amount': this.amount,
    'isCredit': this.isCredit,
    'date': this.date,
    'time': this.time,
  };




}

@HiveType(typeId: 1)
class Target extends HiveObject {
  @HiveField(0)
  double target;

  Target({required this.target});
}
