import 'package:flutter/material.dart';

import 'back_restore.dart';

class BackupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

  showAlertDialog(BuildContext context) {

  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () { },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Backup successfully done"),
    content: Text("A backup of your transaction messages has successfully been created."),
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Backup Data'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.backup,
              size: 100,
              color: Colors.indigo
            ),
            SizedBox(height: 16),
            Text(
              'Create a backup of your data',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                backupDatabase();
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
