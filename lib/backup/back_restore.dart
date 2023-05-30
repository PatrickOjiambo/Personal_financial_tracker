/*
import 'dart:convert';
import 'dart:io';
import 'dart:js';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:permission_handler/permission_handler.dart';

import 'database.dart';

class Backup extends StatelessWidget {
  const Backup({super.key});

  @override
  Widget build(BuildContext context) {

 
Future<Directory> _getDirectory() async {
    const String pathExt = 'Transacations/';//This is the name of the folder where the backup is stored
    Directory newDirectory = Directory('/storage/emulated/0/' + pathExt);//Change this to any desired location where the folder will be created
    if (await newDirectory.exists() == false) {
      return newDirectory.create(recursive: true);
    }
    return newDirectory;
  }    

  // Copy the current database file to the back
Future<void> createBackup() async {
if (Hive.box<Database>('products').isEmpty) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('No Products Stored.')),
  );
  return;
}
ScaffoldMessenger.of(context).showSnackBar(
  const SnackBar(content: Text('Creating backup...')),
);
Map<String, dynamic> map = Hive.box<Database>('products')
    .toMap()
    .map((key, value) => MapEntry(key.toString(), value));
String json = jsonEncode(map);
await Permission.storage.request();
Directory dir = await _getDirectory();
String formattedDate = DateTime.now()
    .toString()
    .replaceAll('.', '-')
    .replaceAll(' ', '-')
    .replaceAll(':', '-');
String path = '${dir.path}$formattedDate.json';//Change .json to your desired file format(like .barbackup or .hive).
File backupFile = File(path);
await backupFile.writeAsString(json);
ScaffoldMessenger.of(context).showSnackBar(
  const SnackBar(content: Text('Backup saved in folder Transactions')),
);}


   

   Future<void> restoreBackup() async {
ScaffoldMessenger.of(context).showSnackBar(
  const SnackBar(content: Text('Restoring backup...')),
);
FilePickerResult? file = await FilePicker.platform.pickFiles(
  type: FileType.any,
);
if (file != null) {
  File files = File(file.files.single.path.toString());
  Hive.box<Database>('products').clear();
  Map<String, dynamic> map = jsonDecode(await files.readAsString());
  for (var i = 0; i < map.length; i++) {
    //Database product = Database.fromJson(i.toString(), map);
    Hive.box<Database>('products').add(product);
  }
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Restored Successfully...')),
  );
}
}
}
}

*/

