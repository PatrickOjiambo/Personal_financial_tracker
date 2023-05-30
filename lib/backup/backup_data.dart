import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:hive/hive.dart';
import 'package:permission_handler/permission_handler.dart';

import 'database.dart';

class BackupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<Directory> _getDirectory() async {
      const String pathExt =
          'Transacations/'; //This is the name of the folder where the backup is stored
      Directory newDirectory = Directory('/storage/emulated/0/' +
          pathExt); //Change this to any desired location where the folder will be created
      if (await newDirectory.exists() == false) {
        return newDirectory.create(recursive: true);
      }
      return newDirectory;
    }

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
      String path =
          '${dir.path}$formattedDate.json'; //Change .json to your desired file format(like .barbackup or .hive).
      File backupFile = File(path);
      await backupFile.writeAsString(json);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Backup saved in folder Transactions')),
      );
    }

    showAlertDialog(BuildContext context) {
      // set up the button
      Widget okButton = TextButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("Backup successfully done"),
        content: Text(
            "A backup of your transaction messages has successfully been created."),
        actions: [
          okButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    // Call showDialog in a separate function after the Scaffold is returned
    void showProgressDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Backup Data'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.backup, size: 100, color: Colors.indigo),
            SizedBox(height: 16),
            Text(
              'Create a backup of your transaction data',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                showProgressDialog(context); // Show progress dialog first
                Navigator.of(context).pop();
                createBackup();
                showAlertDialog(context);
              },
              child: Text(
                'Backup Now',
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                textStyle: TextStyle(color: Colors.white),
                backgroundColor: Colors.indigo,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
