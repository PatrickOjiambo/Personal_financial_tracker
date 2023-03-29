import 'package:sqflite/sqflite.dart' as sql;

class SQLDatabase{
  static Future<void> createTables(sql.Database database) async{
     print('*******************Creating tables**************');
    await database.execute("""CREATE TABLE messages(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        address TEXT,
        status TEXT,
        amount TEXT,
        recipient TEXT,
        date TEXT,
        createAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        )
    """);
    print('**************Table created successfully**************');



  }
  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'messages.db',
      version: 1,
      onCreate: (sql.Database database, int version) async{
        print('**************Table created successfully**************');
        await createTables(database);
      },
    );
  }

  static Future<void> insertMessage({
    required String address,
    required String status,
    required String amount,
    required String recipient,
    required String date,
  }) async {
    final db = await SQLDatabase.db();

    await db.insert(
      'messages',
      {
        'address': address,
        'status': status,
        'amount': amount,
        'recipient': recipient,
        'date': date,
      },
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
    print('******Message inserted successfully*******');

  }

}